//
// Copyright (c) 2024 Cory Ginsberg.
// Licensed under the Apache License, Version 2.0
//

import AlertToast
import SwiftSoup
import SwiftUI

struct CommentCellContent: View {
  @Binding var commentData: CommentData
  @Binding var indent: Int
  @Binding var hidden: Bool

  @State private var showingAlert = false
  @StateObject var childCommentList: CommentListViewModel

  var body: some View {
    if hidden {
      VStack {
        SecondaryCommentInfoGroup(
          commentData: commentData,
          showingAlert: $showingAlert
        )
        Divider()
      }
    } else {
      LazyVStack {
        CommentText(commentData: $commentData)
        SecondaryCommentInfoGroup(
          commentData: commentData,
          showingAlert: $showingAlert
        )
        Divider()

        // Child Comments
        if !childCommentList.items.isEmpty {
          ForEach(childCommentList.items) { child in
            if let childData = child.itemData as? CommentData {
              CommentCell(
                commentData: childData,
                indent: indent + 1
              )
            }
          }
        }
      }
    }
  }
}

// MARK: - Comment Text

struct CommentText: View {
  @Binding var commentData: CommentData

  @EnvironmentObject var viewModel: AlertViewModal

  private let pasteboard = UIPasteboard.general

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

    if let commentText = try? AttributedString(
      markdown: "\(prefixText)\(commentData.text ?? "")"
    ) {
      Text(commentText)
        .commentStyle(isDead: commentData.dead)
        .contextMenu {
          Button {
            copyToClipboard(commentText: String(commentText
                .characters[...]))
          } label: {
            Label("Copy", systemImage: "doc.on.doc")
          }
          Button {} label: {
            Label("Share", systemImage: "square.and.arrow.up")
          }
        }
    }
  }
}
