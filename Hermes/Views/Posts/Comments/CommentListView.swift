//
// Copyright (c) 2023 - Present Cory Ginsberg
// Licensed under Apache License 2.0
//

import SwiftData
import SwiftUI

// MARK: - CommentListView

struct CommentListView: View {
  @Environment(\.modelContext) private var modelContext
  var selectedPost: Post?

  var isPreview = false

//  init(for selectedPost: Post?) {
//    self.selectedPost = selectedPost
//  }

  var body: some View {
    Text(selectedPost?.title ?? "")
//    NavigationStack {
//      ScrollView(.vertical) {
//        if let selectedPost {
//          VStack {
//            PostCell(post: selectedPost, isCommentView: true).padding(.leading)
//          }.padding(.trailing, 8.0)
//        } else {
//          Text("No post selected")
//        }
//      }
//    }.navigationTitle("\(selectedPost?.numComments ?? 0) Comments")
//      .navigationBarTitleDisplayMode(.inline)
//      .onChange(of: selectedPost, initial: true) {}
  }
}

// #Preview("Post With Text") {
//  ModelContainerPreview(PreviewSampleData.inMemoryContainer) {
//    CommentListView(selectedPost: .constant(Post.formattedText), isPreview: true)
//  }
// }
//
// #Preview("Post With Link") {
//  ModelContainerPreview(PreviewSampleData.inMemoryContainer) {
//    CommentListView(selectedPost: .constant(Post.link), isPreview: true)
//  }
// }
//
// #Preview("No Post Selected") {
//  ModelContainerPreview(PreviewSampleData.inMemoryContainer) {
//    CommentListView(selectedPost: .constant(nil), isPreview: true)
//  }
// }
