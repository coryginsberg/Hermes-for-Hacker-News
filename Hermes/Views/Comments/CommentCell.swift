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
  @State var hidden: Bool = false
  @StateObject var childCommentList: CommentListViewModel

  var childComments: [CommentData] = []

  init(commentData: CommentData, indent: Int) {
    _commentData = State(wrappedValue: commentData)
    _indent = State(wrappedValue: indent)
    _childCommentList = StateObject(wrappedValue: CommentListViewModel(withComments: commentData
        .kids ?? []))
  }

  var body: some View {
    CommentCellContent(
      commentData: $commentData,
      indent: $indent,
      hidden: $hidden,
      childCommentList: childCommentList
    ).indent($indent)
      .contentShape(Rectangle())
      .onTapGesture {
        hidden.toggle()
      }
  }
}

// MARK: - Comment indent style

struct CommentCellStyle: ViewModifier {
  @Binding var indent: Int

  private let colors: [Color] = [
    .red,
    .orange,
    .yellow,
    .green,
    .cyan,
    .blue,
    .purple,
  ]

  func body(content: Content) -> some View {
    HStack {
      if indent > 0 {
        colors[indent - 1 % colors.count]
          .frame(width: 1.5)
          .clipShape(
            RoundedRectangle(
              cornerRadius: 24
            )
          )
          .padding(.leading, indent == 1 ? 1 : 0)
          .padding(.bottom, 8.0)
          .padding(.top, 2.0)
      }
      content.padding(.leading, 2.0)
    }
  }
}

// MARK: - Comment indent style view modifier

extension View {
  func indent(_ indent: Binding<Int>) -> some View {
    modifier(CommentCellStyle(indent: indent))
  }
}

#Preview {
  CommentCell(commentData: TestData.Comments.randomComments[0], indent: 0)
}
