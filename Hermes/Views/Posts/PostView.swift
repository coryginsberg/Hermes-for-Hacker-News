//
// Copyright (c) 2023 - Present Cory Ginsberg
// Licensed under Apache License 2.0
//

import SwiftData
import SwiftUI

struct PostView: View {
  @Environment(\.modelContext) private var modelContext
  @Query(sort: \Post.rank) private var posts: [Post]
  @State private var selectedPostID: Post.ID?
  @State private var lastLoadedPage: Int = 1
  @State private var sort: SortOption = .news

  @State private var postListParser = try? PostListParser()

  func fetch(loadMore _: Bool = false, forceRefresh: Bool = false) {
    if forceRefresh {
      lastLoadedPage = 1
    }
    Task(priority: .userInitiated) {
      let document = try await PostListPageFetcher().fetch(
        sort,
        page: lastLoadedPage
      )
      self.postListParser = try PostListParser(document)
      try await self.postListParser?.queryAllElements(for: modelContext.container)
      lastLoadedPage += 1
    }
  }

  func genFetch() async throws {
    let document = try await PostListPageFetcher().fetch(
      sort,
      page: lastLoadedPage
    )

    do {
      postListParser = try PostListParser(document)
      try await postListParser?.queryAllElements(for: modelContext.container)
    } catch {
      print(error)
    }
  }

  var body: some View {
    NavigationSplitView {
      switch self.postListParser?.state {
      case .idle:
        ProgressView()
      case .loading:
        ProgressView()
      case .loaded(nil), .loaded(.some):
        List(posts, selection: $selectedPostID) { post in
          if !post.isHidden {
            PostCell(post: post)
              .task(priority: .background) {
                if posts
                  .count - numBeforeLoadMore == post.rank &&
                  lastLoadedPage <= HN.Posts.maxNumPages {
                  fetch(loadMore: true)
                }
              }
              .onChange(of: selectedPostID) {
                if let selectedPostID, selectedPostID == post.id {
                  if post.postHistory == nil {
                    let history = PostHistory(post: post)
                    modelContext.insert(history)
                    post.postHistory = history
                    do {
                      try modelContext.save()
                    } catch {
                      print(error)
                    }
                  }
                }
              }
          }
        }
        .postListNavigation(sort: $sort) {
          fetch(forceRefresh: true)
        }
        .onChange(of: sort) {
          fetch(forceRefresh: true)
        }
        .task(priority: .background) {}
      case .failed(let error):
        Text(error.localizedDescription)
      case .empty:
        Text("Nothing loaded")
      case .none:
        Text("Nothing loaded")
      }
    } detail: {
      CommentListView(selectedPost: Binding.constant(posts[selectedPostID]))
    }
    .task {
      do {
        try await genFetch()
      } catch {
        print(error)
      }
    }
  }
}

#Preview {
  PostView()
    .modelContainer(for: Post.self, inMemory: true)
}
