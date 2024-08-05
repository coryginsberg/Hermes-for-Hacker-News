//
// Copyright (c) 2023 - Present Cory Ginsberg
// Licensed under Apache License 2.0
//

import SwiftData
import SwiftUI

struct PostView: View {
  @Environment(\.modelContext) private var modelContext
  @Query private var posts: [Post]
  @State private var selectedPostID: Post.ID?

  var body: some View {
    NavigationSplitView {
      List(posts, selection: $selectedPostID) {
        PostCell(post: $0)
      }
      .navigationTitle("Posts")
      .listStyle(.plain)
      .refreshable {
        do {
          let document = try await PostListPageFetcher().fetch()
          try PostListParser(document).queryAllElements(for: modelContext)
        } catch {
          print(error)
        }
      }
    } detail: {
      CommentListView(selectedPost: Binding.constant(posts[selectedPostID]))
    }
    .task {
      do {
        let document = try await PostListPageFetcher().fetch()
        try PostListParser(document).queryAllElements(for: modelContext)
      } catch {
        print(error)
      }
    }
  }
}

#Preview {
  PostView()
//    .environment(PostView.ViewModel())
    .modelContainer(for: Post.self, inMemory: true)
}
