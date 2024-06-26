//
// Copyright (c) 2023 - Present Cory Ginsberg
// Licensed under Apache License 2.0
//

import SwiftData
import SwiftUI

struct PostTabView: View {
  @Environment(ViewModel.self) private var viewModel
  @Environment(\.modelContext) private var modelContext
  @Environment(\.scenePhase) private var scenePhase
  @Query(sort: \Post.index) private var posts: [Post]
  @State private var selectedPost: Post?

  var body: some View {
    ZStack {
      NavigationSplitView {
        List(posts, selection: $selectedPost) { post in
          PostCell(post: post)
        }.listStyle(.plain)
          .refreshable {
            await AngoliaSearchResults.refresh(modelContext: modelContext)
          }.navigationTitle("Posts")
      } detail: {
        CommentListView(selectedPost: $selectedPost)
      }
      .task {
        await AngoliaSearchResults.refresh(modelContext: modelContext)
      }
    }
  }
}

#Preview {
  PostTabView()
    .environment(ViewModel())
    .modelContainer(for: Post.self, inMemory: true)
}
