//
//  Copyright (c) 2022 Cory Ginsberg.
//  Licensed under the Apache License, Version 2.0
//

import SwiftUI

// MARK: - CommentListView

struct CommentListView: View {
  @State var postData: ItemData
  @StateObject var commentList = CommentListViewModel()

  var body: some View {
    NavigationView {
      ScrollView {
        LazyVStack {
          PostCellText(postData: postData)
          ForEach(commentList.comments) { comment in
            CommentCell(commentData: comment.delegate.itemData)
          }
        }
      }
    }
    .navigationTitle(Text(""))
    .navigationBarTitleDisplayMode(.inline)
  }
}

// MARK: - PostCommentView_Previews

struct PostCommentView_Previews: PreviewProvider {
  static var previews: some View {
    CommentListView(postData: TestData.Posts.randomPosts[0])
  }
}
