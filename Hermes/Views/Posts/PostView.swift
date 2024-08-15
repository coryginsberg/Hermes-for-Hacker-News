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
  @State private var isLoading: Bool = false
  @State private var sort: SortOption = .news

  func fetch(loadMore _: Bool = false, forceRefresh: Bool = false) {
    if forceRefresh {
      lastLoadedPage = 1
    }
    defer {
      isLoading = false
    }
    Task(priority: .background) {
      let document = try await PostListPageFetcher().fetch(
        sort,
        page: lastLoadedPage
      )
      try PostListParser(document).queryAllElements(for: modelContext)
      lastLoadedPage += 1
    }
  }

  var body: some View {
    NavigationSplitView {
      List(posts, selection: $selectedPostID) { post in
        if !post.isHidden {
          PostCell(post: post)
            .task(priority: .background) {
              if posts
                .count - numBeforeLoadMore == post.rank && !isLoading &&
                lastLoadedPage <= HN.Posts.maxNumPages {
                isLoading = true
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
        if isLoading {
          LoadingWheel()
        }
      }
      .postListNavigation(sort: $sort) {
        fetch(forceRefresh: true)
      }
      .onChange(of: sort) {
        fetch(forceRefresh: true)
      }
    } detail: {
      CommentListView(selectedPost: Binding.constant(posts[selectedPostID]))
    }
    .task {
      fetch()
    }
  }
}

#Preview {
  PostView()
    .modelContainer(for: Post.self, inMemory: true)
}
