//
// Copyright (c) 2023 - Present Cory Ginsberg
// Licensed under Apache License 2.0
//

import SwiftData
import SwiftUI

// MARK: - CommentListView

struct CommentListView: View {
  var isPreview = false
  @Binding var selectedPost: Post?

  @ObservedObject private var algoliaItemLoader = AlgoliaCommentsViewModel()

  var body: some View {
    NavigationStack {
      ScrollView(.vertical) {
        VStack {
          if let selectedPost {
            PostCell(forPost: selectedPost, isCommentView: true)
          }
          switch algoliaItemLoader.state {
          case .idle:
            ProgressView()
          case .loading:
            ProgressView()
          case .failed(let error):
            Text("Loading failed with error: \(error.localizedDescription)")
          case .empty:
            Text("Looks like there's no comments here yet")
          case .loaded(let algoliaItems):
            CommentListLoadedView(algoliaItems: algoliaItems)
          }
        }.padding(.trailing, 16.0)
      }
    }.navigationTitle("\(selectedPost?.numComments ?? 0) Comments")
      .navigationBarTitleDisplayMode(.inline)
      .onChange(of: selectedPost, initial: true) {
        if let selectedPost {
          Task {
            await algoliaItemLoader.load(from: selectedPost, isPreview: isPreview)
          }
        }
      }
  }
}

#Preview {
  CommentListView(isPreview: true, selectedPost: Binding.constant(.preview))
}
