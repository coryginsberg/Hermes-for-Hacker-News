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
          .frame(width: 2.0)
          .overlay(.cyan)
          .padding(
            .leading,
            2.0
          )
          .padding(.bottom, 8.0)
          .padding(.top, 2.0)
      }
      CommentCellContent(
        commentData: commentData,
        indent: indent,
        childCommentList: childCommentList
      ).padding(.leading, 2)
    }
  }
}

struct CommentCellContent: View {
  @State var commentData: CommentData
  @State var indent: Int
  @StateObject var childCommentList: CommentListViewModel
  @State private var showingAlert = false
  private let pasteboard = UIPasteboard.general

  @Environment(\.dismiss) var dismiss
  @EnvironmentObject var viewModel: AlertViewModal

  func copyToClipboard(commentText: String) {
    viewModel.alertToast = AlertToast(
      displayMode: .hud,
      type: .complete(.green),
      title: "Text copied"
    )
    DispatchQueue.main.asyncAfter(deadline: .now() + 1.5, qos: .utility) {
      pasteboard.string = commentText
      viewModel.show.toggle()
    }
  }

  var body: some View {
    let prefixText = commentData.dead ? "[dead] " : commentData
      .deleted ? "[deleted] " : ""

    let commentText = try! AttributedString(
      markdown: "\(prefixText)\(commentData.text ?? "")"
    )

    LazyVStack {
      Text(commentText)
        .commentStyle(isDead: commentData.dead)
        .contextMenu {
          Button {
            copyToClipboard(commentText: String(commentText.characters[...]))
          } label: {
            Label("Copy", systemImage: "doc.on.doc")
          }
          Button {} label: {
            Label("Share", systemImage: "square.and.arrow.up")
          }
        }

      SecondaryCommentInfoGroup(
        commentData: commentData,
        showingAlert: $showingAlert
      )
      Divider()

      // MARK: - Child Comments

      if !childCommentList.items.isEmpty {
        ForEach(childCommentList.items, content: {
          CommentCell(
            commentData: $0.delegate.itemData as! CommentData,
            indent: indent + 1
          )
        })
      }
    }
  }
}

#Preview {
  CommentCell(commentData: TestData.Comments.randomComments[0], indent: 0)
}
