//
// Copyright (c) 2024 Cory Ginsberg.
// Licensed under the Apache License, Version 2.0
//

import Foundation
import SwiftData
import SwiftUI

// MARK: - PostListView

struct PostList: View {
  @Environment(ViewModel.self) private var viewModel
  @Environment(\.modelContext) private var modelContext
  @Query(sort: \Post.index) private var posts: [Post]

  @Binding var selectedId: Post.ID?

  init(
    selectedId: Binding<Post.ID?>
  ) {
    _selectedId = selectedId
  }

  var body: some View {
    List(posts, selection: $selectedId) { post in
      PostCell(forPost: post)
    }
    .refreshable {
      await HNSearchResults.refresh(modelContext: modelContext)
    }
  }
}

// MARK: - PostsListView_Previews

struct PostsList_Previews: PreviewProvider {
  static var previews: some View {
    PostList(selectedId: Binding.constant(nil))
      .environment(ViewModel())
      .modelContainer(for: Post.self, inMemory: true)
  }
}
