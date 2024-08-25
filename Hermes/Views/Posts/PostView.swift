//
// Copyright (c) 2024 Cory Ginsberg.
// Licensed under the Apache License, Version 2.0
//

import Foundation
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
    NavigationSplitView {
      List(posts, selection: $selectedPostID) { post in
        if !post.isHidden {
          PostCell(post: post)
            .task(priority: .background) {
              if posts.count - numBeforeLoadMore == post.rank &&
                !isLoading &&
                lastLoadedPage <= HN.Posts.maxNumPages {
                isLoading = true
                fetch(loadMore: true)
              }
            }
            .onChange(of: selectedPostID) {
              if let selectedPostID, selectedPostID == post.id {
                updateViewedPost(post)
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
