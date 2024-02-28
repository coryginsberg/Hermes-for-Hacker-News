//
// Copyright (c) 2024 Cory Ginsberg.
// Licensed under the Apache License, Version 2.0
//

import AlertToast
import SwiftUI
import WebKit

// MARK: - CommentCell

struct CommentCell: View {
  @State var commentData: CommentData
  @State var indent: Int
  @StateObject var childCommentList: CommentListViewModel

  var childComments: [CommentData] = []

  init(commentData: CommentData, indent: Int) {
    _commentData = State(wrappedValue: commentData)
    _indent = State(wrappedValue: indent)
    _childCommentList =
      StateObject(wrappedValue: CommentListViewModel(withComments: commentData
          .kids ?? []))
  }

  var body: some View {
    HStack {
      if indent > 0 {
        Divider()
          .frame(width: 1.0)
          .overlay(Color(.systemOrange))
          .padding(.leading, indent == 1 ? 1.0 : 0)
          .padding(.bottom, 8.0)
          .padding(.top, 2.0)
      }
      CommentCellContent(
        commentData: commentData,
        indent: indent,
        childCommentList: childCommentList
      ).padding(.leading, 2.0)
    }
  }
}

#Preview {
  CommentCell(commentData: TestData.Comments.randomComments[0], indent: 0)
}
