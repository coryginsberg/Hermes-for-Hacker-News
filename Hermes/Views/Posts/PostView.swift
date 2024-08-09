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

  func fetch(loadMore: Bool = false, forceRefresh: Bool = false) {
    if forceRefresh {
      lastLoadedPage = 1
    }
    defer {
      isLoading = false
    }
    Task(priority: forceRefresh ? .userInitiated : .background) {
      let document = try await PostListPageFetcher().fetch(page: lastLoadedPage)
      try PostListParser(document).queryAllElements(for: modelContext)
      lastLoadedPage += 1
    }
  }

  var body: some View {
    NavigationSplitView {
      List(selection: $selectedPostID) {
        Section {
          ForEach(Array(posts.enumerated()), id: \.self.element.id) { i, post in
            if !post.isHidden {
              PostCell(post: post)
                .task(priority: .background) {
                  if posts.count - numBeforeLoadMore == i && !isLoading && lastLoadedPage <= HN.Posts.maxNumPages {
                    isLoading = true
                    fetch(loadMore: true)
                  }
                }
                .onChange(of: selectedPostID) {
                  if let selectedPostID, selectedPostID == post.id {
                    post.isViewed = true
                  }
                }
            }
          }
        }
        if isLoading {
          LoadingWheel()
        }
      }
      .navigationTitle("Posts")
      .listStyle(.plain)
      .refreshable {
        fetch(forceRefresh: true)
      }
      .listRowBackground(Color.clear)
      .listSectionSeparator(.hidden)
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
//    .environment(PostView.ViewModel())
    .modelContainer(for: Post.self, inMemory: true)
}
