//
// Copyright(c) 2023 - Present Cory Ginsberg
// Licensed under Apache License 2.0
//

import AlertToast
import SwiftUI

struct CommentBody: View {
  @Binding var commentData: Comment
  @Binding var showingAlert: Bool
  @Binding var hidden: Bool
//  @Binding var indent: Int

  var body: some View {
    VStack {
      if !hidden {
        CommentText(commentData: $commentData)
      }
      SecondaryCommentInfoGroup(
        comment: commentData,
        showingAlert: $showingAlert
      )
      Divider()
    }
  }
}

// MARK: - Comment Text

private struct CommentText: View {
  @Binding var commentData: Comment
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
    if let commentText = try? AttributedString(
      markdown: "\(commentData.text)"
    ) {
      Text(commentText)
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
