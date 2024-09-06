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

  let secondaryTextColor = Color(uiColor: .secondaryLabel)
  let spacer: Spacer = .init(minLength: 4.0)
  let scaledSize = UIFontMetrics.default.scaledValue(for: UIFont.systemFontSize)

  var body: some View {
    VStack(alignment: .leading) {
      PrimaryLabel(
        post: $post,
        isCommentView: $isCommentView
      )
    }
  }
}
