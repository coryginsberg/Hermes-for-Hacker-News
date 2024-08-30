//
// Copyright (c) 2023 - Present Cory Ginsberg
// Licensed under Apache License 2.0
//

import Foundation
import SwiftData
import SwiftUI

struct PostView: View {
  @Environment(\.modelContext) private var modelContext
  @Query(sort: \Post.rank) private var posts: [Post]
  @State private var selectedPostID: Post.ID?
  @State private var lastLoadedPage: Int = 0
  @State private var isLoading: Bool = false
  @State private var sort: SortOption = .news

  func fetch(forceRefresh: Bool = false) {
    let container = modelContext.container
    let modelActor = PostModelActor(modelContainer: container)
    if forceRefresh {
      lastLoadedPage = 0
      Task.detached {
        try? await modelActor.delete()
      }
    }
    defer {
      isLoading = false
      lastLoadedPage += 1
    }
    Task.detached {
      let document = try await PostListPageFetcher().fetch(
        sort,
        page: lastLoadedPage
      )
      try? await PostListParser(document).queryAllElements(for: container)
    }
  }

  func updateViewedPost(_ post: Post) {
    if !post.viewed {
      // FIXME: Why does this work but @AppStorage doesn't?
      let viewedPosts = UserDefaults.standard.array(forKey: UserDefaultKeys.viewedPosts.rawValue)
      if var viewedPosts {
        viewedPosts.append(post.itemId)
        UserDefaults.standard.set(viewedPosts, forKey: UserDefaultKeys.viewedPosts.rawValue)
      }
      post.viewed = true
    }
  }

  var body: some View {
    NavigationStack {
      List(posts, selection: $selectedPostID) { post in
        PostCell(post: post)
          .task {
            if posts.count - numBeforeLoadMore >= post.rank &&
              !isLoading &&
              lastLoadedPage <= HN.Posts.maxNumPages {
              isLoading = true
              fetch()
            } else {
              print(posts.count - numBeforeLoadMore)
              print(post.rank)
              print(lastLoadedPage)
            }
          }
          .onChange(of: selectedPostID) {
            if let selectedPostID, selectedPostID == post.id {
              updateViewedPost(post)
            }
          }
        if isLoading {
          LoadingWheel()
        }
      }
      .navigationDestination(item: $selectedPostID) { _ in
        CommentListView(selectedPost: Binding.constant(posts[selectedPostID]))
      }
      .navigationBar(for: .postView($sort)) {
        fetch(forceRefresh: true)
      }
      .onChange(of: sort) {
        fetch(forceRefresh: true)
      }
    }
    .onAppear {
      fetch(forceRefresh: true)
    }
  }
}

#Preview {
  PostView()
    .modelContainer(for: Post.self, inMemory: true)
}
