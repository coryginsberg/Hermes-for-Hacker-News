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

  func fetch(loadMore: Bool = false, forceRefresh: Bool = false) {
    Task(priority: forceRefresh ? .userInitiated : .background) {
      let document = try await PostListPageFetcher().fetch()
      try PostListParser(document).queryAllElements(for: modelContext)
    }
  }

  var body: some View {
    NavigationSplitView {
      List(posts, selection: $selectedPostID) {
        PostCell(post: $0)
      }
      .navigationTitle("Posts")
      .listStyle(.plain)
      .refreshable {
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
//    .environment(PostView.ViewModel())
    .modelContainer(for: Post.self, inMemory: true)
}
