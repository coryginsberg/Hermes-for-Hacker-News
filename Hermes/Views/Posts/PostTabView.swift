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

  @State private var selectedId: Post.ID?

  var body: some View {
    NavigationSplitView {
      List(posts, selection: $selectedId) { post in
        PostCell(forPost: post)
      }
      .refreshable {
        await AngoliaSearchResults.refresh(modelContext: modelContext)
      }
    } detail: {
      CommentListView(selectedPostID: $selectedId, selectedPost: posts.first(where: { post in
        post.id == selectedId
      }))
    }
    .task {
      await AngoliaSearchResults.refresh(modelContext: modelContext)
    }
    .onAppear {
#if DEBUG
      log(category: "sqlite").debug("\(modelContext.sqliteCommand)")
#endif
    }
  }
}

#Preview {
  PostTabView()
    .environment(ViewModel())
    .modelContainer(for: Post.self, inMemory: true)
}
