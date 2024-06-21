//
// Copyright (c) 2023 - Present Cory Ginsberg
// Licensed under Apache License 2.0
//

import FaviconFinder
import SwiftUI

// MARK: - PostCellText

struct PostText: View {
  @Environment(\.sizeCategory) var sizeCategory

  @State var post: Post
  @State var isCommentView: Bool = false
  @State var isFaviconVisible: Bool = true
  @State var styledText: AttributedString?

  let secondaryTextColor = Color(uiColor: .secondaryLabel)
  let spacer: Spacer = .init(minLength: 4.0)
  let scaledSize = UIFontMetrics.default.scaledValue(for: UIFont.systemFontSize)

  var body: some View {
    VStack(alignment: .leading) {
      PostPrimaryLabel(
        post: post,
        isCommentView: isCommentView
      )
      if isCommentView, let text = post.text {
        if let styledText {
          Text(styledText)
        } else {
          // fallback
          Text(text)
        }
      }
      PostSecondaryLabel(post: post, textColor: secondaryTextColor)
    }
    .padding(.leading, isFaviconVisible ? 16.0 : 0)
    .onAppear {
      if let text = post.text, let formattedText = try? HTMLAttributedString.formatForHN(text: text, size: scaledSize) {
        styledText = formattedText
      }
    }
  }
}

#Preview("Comment View") {
  ModelContainerPreview(PreviewSampleData.inMemoryContainer) {
    VStack {
      PostText(post: Post.formattedText, isCommentView: true, isFaviconVisible: false)
    }.padding()
  }
}
