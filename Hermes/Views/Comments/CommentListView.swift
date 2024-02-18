//
//  Copyright (c) 2022 Cory Ginsberg.
//  Licensed under the Apache License, Version 2.0
//

import SwiftUI

// MARK: - CommentListView

struct CommentListView: View {
  @State var postData: ItemData

  var body: some View {
    NavigationView {
      ScrollView {
        LazyVStack {
          PostCellOuterView(postData: postData, isCommentView: true)
          if let kids = postData.kids, !kids.isEmpty {
            ForEach(kids, id: \.self) { _ in
              CommentCell(commentData:
                TestData.Comments.randomComments.randomElement() ??
                  TestData.Comments.randomComments[0],
                indent: 0)
            }
          } else {
            Text("Looks like there's no comments here yet")
          }
        }
      }
    }
    .navigationTitle(Text(""))
    .navigationBarTitleDisplayMode(.inline)
  }
}

// MARK: - PostCommentView_Previews

#Preview {
  CommentListView(postData: TestData.Posts.randomPosts[0])
}
