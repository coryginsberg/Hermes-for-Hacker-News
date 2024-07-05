//
// Copyright (c) 2023 - Present Cory Ginsberg
// Licensed under Apache License 2.0
//

import SwiftData
import SwiftUI

// MARK: - CommentListView

struct CommentListView: View {
  @Environment(\.modelContext) private var modelContext
  @ObservedObject private var algoliaItemLoader = AlgoliaCommentsViewModel()
  @Binding var selectedPost: Post?

  var isPreview = false

  var body: some View {
    NavigationStack {
      ScrollView(.vertical) {
        if let selectedPost {
          VStack {
            PostCell(post: selectedPost, isCommentView: true).padding(.leading)
            switch algoliaItemLoader.state {
            case .idle:
              Text("Idle")
            case .loading:
              ProgressView()
            case .failed(let error):
              ErrorText(error, errorType: .loading)
            case .empty:
              Text("Looks like there's no comments here yet")
            case .loaded(let algoliaItems):
              CommentListLoadedView(algoliaItems: algoliaItems).padding(.leading, 4.0)
            }
          }.padding(.trailing, 8.0)
        } else {
          Text("No post selected")
        }
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

#Preview("Post With Text") {
  ModelContainerPreview(PreviewSampleData.inMemoryContainer) {
    CommentListView(selectedPost: .constant(Post.formattedText), isPreview: true)
  }
}

#Preview("Post With Link") {
  ModelContainerPreview(PreviewSampleData.inMemoryContainer) {
    CommentListView(selectedPost: .constant(Post.link), isPreview: true)
  }
}

#Preview("No Post Selected") {
  ModelContainerPreview(PreviewSampleData.inMemoryContainer) {
    CommentListView(selectedPost: .constant(nil), isPreview: true)
  }
}
