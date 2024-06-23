//
// Copyright (c) 2023 - Present Cory Ginsberg
// Licensed under Apache License 2.0
//

import FaviconFinder
import MarkdownifyHTML
import SwiftUI

// MARK: - PostCellText

struct PostText: View {
  @State var post: Post
  @State var isCommentView: Bool = false
  @State var isFaviconVisible: Bool = true

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
        TextBlockView(text: text)
      }
      PostSecondaryLabel(post: post, textColor: secondaryTextColor)
    }
    .padding(.leading, isFaviconVisible ? 16.0 : 0)
  }
}

#Preview("Comment View") {
  ModelContainerPreview(PreviewSampleData.inMemoryContainer, addPadding: true) {
    PostText(post: Post.formattedText, isCommentView: true, isFaviconVisible: false)
  }
}
