//
// Copyright (c) 2023 - Present Cory Ginsberg
// Licensed under Apache License 2.0
//

import Foundation
import SwiftData
import SwiftUI

struct PostsListView: View {
  @Environment(\.modelContext) private var modelContext
  @Query(sort: \Post.rank) private var posts: [Post]

  @State private var selectedPostID: Post.ID?
  @State private var lastLoadedPage: Int = 0
  @State private var isLoading: Bool = false
  @State private var sort: SortOption = .news

  @Default(.viewedPosts) var viewedPosts

  // For SwiftUI Previews only! Value should only be changed in #Preview blocks
  var isPreview: Bool = false

  func fetch(forceRefresh: Bool = false) {
    if isPreview {
      return
    }
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

  var body: some View {
    NavigationStack {
      List(posts, selection: $selectedPostID) { post in
        NavigationLink(value: post) {
          PostCell(post: post)
            .task {
              if posts.count - numBeforeLoadMore >= post.rank &&
                !isLoading &&
                lastLoadedPage <= HN.Posts.maxNumPages {
                isLoading = true
                fetch()
              }
            }
        }.onChange(of: selectedPostID) {
          if let selectedPostID, selectedPostID == post.id {
            viewedPosts.insert(post.itemId)
          }
        }
      }
      .navigationDestination(for: Post.self) { post in
        CommentListView(selectedPost: post)
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

#Preview("Test Data", traits: .samplePostData) {
  @Previewable @State var isPreview = true
  PostsListView(isPreview: isPreview)
}

#Preview("Live Data") {
  PostsListView().modelContainer(for: Post.self, inMemory: true)
}
