//
// Copyright (c) 2024 Cory Ginsberg.
// Licensed under the Apache License, Version 2.0
//

import SwiftUI

// MARK: - PostCellOuter

struct PostCell: View {
  @State var post: Post
  @State var isCommentView: Bool = false

  let secondaryTextColor = Color(uiColor: .secondaryLabel)

  init(forPost post: Post, isCommentView: Bool = false) {
    self.post = post
    self.isCommentView = isCommentView
  }

  var body: some View {
    LazyVStack(alignment: .leading) { // Non-lazy VStack cuts off divider line for some reason
      HStack {
        if let url = post.url {
          PostFavicon(url: url)
        }
        PostText(post: post, isCommentView: isCommentView, isFaviconVisible: post.url != nil)
      }
    }
  }
}
