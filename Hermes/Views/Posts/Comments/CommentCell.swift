//
// Copyright(c) 2023 - Present Cory Ginsberg
// Licensed under Apache License 2.0
//

import AlertToast
import SwiftUI

struct CommentCell: View {
  @Binding var commentData: Comment
  @Binding var showingAlert: Bool
  @Binding var isHidden: Bool
//  @Binding var indent: Int

  var body: some View {
    VStack {
      CommentText(commentData: $commentData)
        .if(isHidden) { view in
          view.frame(height: 0)
        }
        .opacity(isHidden ? 0 : 1)
        .animation(.easeInOut, value: isHidden)

      SecondaryCommentInfoGroup(
        comment: commentData,
        isHidden: $isHidden,
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
        .multilineTextAlignment(.leading)
        .frame(maxWidth: .infinity, alignment: .leading)
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

// #Preview {
//  ModelContainerPreview(PreviewSampleData.inMemoryContainer) {
//    CommentListView(selectedPost: .constant(nil), isPreview: true)
//  }
// }
