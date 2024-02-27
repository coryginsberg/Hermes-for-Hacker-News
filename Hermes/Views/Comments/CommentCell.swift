//
// Copyright (c) 2024 Cory Ginsberg.
// Licensed under the Apache License, Version 2.0
//

import AlertToast
import SwiftUI
import WebKit

// MARK: - CommentCell

struct CommentCell: View {
  @State var commentData: ItemData
  @State var indent: Int
  @StateObject var childCommentList: CommentListViewModel

  var childComments: [ItemData] = []

  init(commentData: ItemData, indent: Int) {
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
  @State var commentData: ItemData
  @State var indent: Int
  @StateObject var childCommentList: CommentListViewModel
  @State private var showingAlert = false
  private let pasteboard = UIPasteboard.general

  @Environment(\.dismiss) var dismiss
  @EnvironmentObject var viewModel: AlertViewModal

  func copyToClipboard(commentText: String) {
    pasteboard.string = commentText
    viewModel.alertToast = AlertToast(
      displayMode: .hud,
      type: .complete(.green),
      title: "Text copied"
    )
    DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
      viewModel.show.toggle()
    }
  }

  var body: some View {
    let primaryColor = commentData
      .dead ? Color(uiColor: .systemGray5) : Color(uiColor: .label)
    let secondaryColor =
      commentData
        .dead ? Color(uiColor: .systemGray5) : Color(uiColor: .secondaryLabel)
    let prefixText = commentData.dead ? "[dead] " : commentData
      .deleted ? "[deleted] " : ""

    let commentText = try! AttributedString(
      markdown: "\(prefixText)\(commentData.text ?? "")"
    )

    LazyVStack {
      // MARK: - Comment Text

      Text(commentText)
        .foregroundColor(primaryColor)
        .multilineTextAlignment(.leading)
        .padding(.bottom, 6.0)
        .allowsTightening(true)
        .frame(maxWidth: .infinity, alignment: .leading)
        .dynamicTypeSize(.medium)
        .textSelection(.enabled)
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

      // MARK: - Comment Info

      HStack {
        Text("– \(commentData.author)")
          .allowsTightening(true)
          .frame(maxWidth: .infinity, alignment: .leading)
          .font(.system(size: 14))
          .foregroundColor(secondaryColor)
          .lineLimit(1)

        Group {
          SecondaryInfoButton(
            systemImage: "arrowshape.turn.up.left",
            textBody: ""
          ) { showingAlert = true }
          SecondaryInfoLabel(
            systemImage: "clock",
            textBody: ItemInfoHelper
              .calcTimeSince(datePosted: commentData.time)
          )
          if commentData.score > 0 {
            SecondaryInfoLabel(
              systemImage: "arrow.up",
              textBody: "\(commentData.score)"
            )
          }
          SecondaryInfoButton(
            systemImage: "ellipsis",
            textBody: ""
          ) { showingAlert = true }
        }.padding(.leading, 6.0)
      }
      Divider()

      // MARK: - Child Comments

      if !childCommentList.items.isEmpty {
        ForEach(childCommentList.items, content: { kid in
          CommentCell(commentData: kid.delegate.itemData, indent: indent + 1)
        })
      }
    }
  }
}

#Preview {
  CommentCell(commentData: TestData.Comments.randomComments[0], indent: 0)
}
