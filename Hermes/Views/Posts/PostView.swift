//
// Copyright (c) 2023 - Present Cory Ginsberg
// Licensed under Apache License 2.0
//

import SwiftData
import SwiftUI

struct PostView: View {
  @Environment(\.modelContext) private var modelContext

  @Query(sort: \Post.index) private var posts: [Post]
  @State private var selectedPostID: Post.ID?

  var body: some View {
    NavigationSplitView {
      PostListView(posts: posts, selectedPostID: $selectedPostID)
    } detail: {
      CommentListView(selectedPost: Binding.constant(posts[selectedPostID]))
    }
    .task {
      await AngoliaSearchResults.refresh(modelContext: modelContext)
    }
  }
}

struct PostListView: View {
  public var posts: [Post]
  @Binding var selectedPostID: Post.ID?
  @Environment(\.modelContext) private var modelContext

  var body: some View {
    List(posts, selection: $selectedPostID) { post in
      PostCell(post: post)
    }
    .listStyle(.plain)
    .navigationTitle("Posts")
    .refreshable {
      await AngoliaSearchResults.refresh(modelContext: modelContext)
    }
  }
}

// #Preview {
//  PostView()
//    .environment(PostView.ViewModel())
//    .modelContainer(for: Post.self, inMemory: true)
// }
