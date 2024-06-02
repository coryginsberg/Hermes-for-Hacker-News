//
// Copyright (c) 2023 - Present Cory Ginsberg
// Licensed under Apache License 2.0
//

import SwiftUI

// MARK: - PostCellOuter

struct PostCell: View {
  @State var post: Post
  @State var isCommentView: Bool = false

  let secondaryTextColor = Color(uiColor: .secondaryLabel)

  var body: some View {
    LazyVStack(alignment: .leading) { // Non-lazy VStack cuts off divider line for some reason
      HStack {
        if let url = post.url {
          PostFavicon(url: url)
        }
        PostText(post: post, isCommentView: isCommentView, isFaviconVisible: post.url != nil)
      }
      if isCommentView {
        Divider()
      }
    }
  }
}
