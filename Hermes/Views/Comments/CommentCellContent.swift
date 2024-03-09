//
// Copyright (c) 2024 Cory Ginsberg.
// Licensed under the Apache License, Version 2.0
//

import AlertToast
import SwiftUI

struct CommentCellContent: View {
  @Binding var commentData: CommentData
  @Binding var indent: Int
  @Binding var hidden: Bool

  @State private var showingAlert = false
  @State private var commentSize: CGSize = .zero
  @StateObject var childCommentList: CommentListViewModel

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
}
