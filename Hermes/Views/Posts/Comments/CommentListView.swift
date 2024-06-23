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
  @Query(sort: \Post.index) private var posts: [Post]
  @Binding var selectedPost: Post.ID?

  var isPreview = false

  var body: some View {
    NavigationStack {
      ScrollView(.vertical) {
        if let selectedPost {
          LazyVStack {
            if let post = posts[selectedPost] {
              PostCell(post: post, isCommentView: true).padding(.leading)
            }
            switch algoliaItemLoader.state {
            case .idle:
              Text("Idle")
            case .loading:
              ProgressView()
            case .failed(let error):
              Text("Loading failed with error: \(error.localizedDescription)")
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
    }.navigationTitle("\(posts[selectedPost]?.numComments ?? 0) Comments")
      .navigationBarTitleDisplayMode(.inline)
      .onChange(of: selectedPost, initial: true) {
        if let post = posts[selectedPost] {
          Task {
            await algoliaItemLoader.load(from: post, isPreview: isPreview)
          }
        }
      }
  }
}

#Preview("Post With Text") {
  ModelContainerPreview(PreviewSampleData.inMemoryContainer) {
    CommentListView(selectedPost: .constant(Post.smallText.id), isPreview: true)
  }
}

#Preview("Post With Link") {
  ModelContainerPreview(PreviewSampleData.inMemoryContainer) {
    CommentListView(selectedPost: .constant(Post.link.id), isPreview: true)
  }
}

#Preview("No Post Selected") {
  ModelContainerPreview(PreviewSampleData.inMemoryContainer) {
    CommentListView(selectedPost: .constant(nil), isPreview: true)
  }
}
