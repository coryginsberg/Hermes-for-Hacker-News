//
// Copyright (c) 2024 Cory Ginsberg.
// Licensed under the Apache License, Version 2.0
//

import FaviconFinder
import SwiftUI

// MARK: - PostCellText

struct PostText: View {
  @State var post: Post
  @State var isCommentView: Bool = false
  @State var isFaviconVisible: Bool = true

  let secondaryTextColor = Color(uiColor: .secondaryLabel)
  let spacer: Spacer = .init(minLength: 4.0)

  var body: some View {
    VStack(alignment: .leading) {
      PostPrimaryLabel(
        post: post,
        secondaryTextColor: secondaryTextColor,
        isCommentView: isCommentView
      )
      PostSecondaryLabel(post: post, textColor: secondaryTextColor)
    }
    .padding(.leading, isFaviconVisible ? 16.0 : 0)
  }
}
