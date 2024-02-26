//
// Copyright (c) 2024 Cory Ginsberg.
// Licensed under the Apache License, Version 2.0
//

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

  @Environment(\.dismiss) var dismiss

  var body: some View {
    let primaryColor = commentData
      .dead ? Color(uiColor: .systemGray5) : Color(uiColor: .label)
    let secondaryColor =
      commentData
        .dead ? Color(uiColor: .systemGray5) : Color(uiColor: .secondaryLabel)
    let prefixText = commentData.dead ? "[dead] " : commentData
      .deleted ? "[deleted] " : ""

    let timePosted = ItemInfoHelper
      .calcTimeSince(datePosted: commentData.time)

    LazyVStack {
      // MARK: - Comment Text

      Text(
        try! AttributedString(
          markdown: "\(prefixText)\(commentData.text ?? "")"
        )
      )
      .foregroundColor(primaryColor)
      .multilineTextAlignment(.leading)
      .padding(.bottom, 6.0)
      .allowsTightening(true)
      .frame(maxWidth: .infinity, alignment: .leading)
      .dynamicTypeSize(.medium)
      .textSelection(.enabled)

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
    }.alert("Alert!", isPresented: $showingAlert, actions: {
      Button("OK", role: .destructive) { dismiss() }
    })
  }
}

#Preview {
  CommentCell(commentData: TestData.Comments.randomComments[0], indent: 0)
}
