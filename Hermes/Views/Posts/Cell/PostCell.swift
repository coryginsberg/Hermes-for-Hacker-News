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
    VStack(alignment: .leading) { // Non-lazy VStack cuts off divider line for some reason
      HStack {
        if let url = post.url {
          PostFavicon(url: url)
        }
        VStack {
          PostText(post: post, isCommentView: isCommentView, isFaviconVisible: post.url != nil)
          if isCommentView, let text = post.text {
            TextBlockView(text: text)
          }
          PostSecondaryLabel(post: post, textColor: secondaryTextColor)
        }
      }
      if isCommentView {
        Divider()
      }
    }
  }
}

#Preview("Front Page") {
  ModelContainerPreview(PreviewSampleData.inMemoryContainer) {
    VStack {
      PostCell(post: Post.smallText, isCommentView: false)
      PostCell(post: Post.mediumText, isCommentView: false)
      PostCell(post: Post.longText, isCommentView: false)
      PostCell(post: Post.link, isCommentView: false)
      PostCell(post: Post.formattedText, isCommentView: false)
    }.padding()
  }
}

#Preview("Comment View") {
  ModelContainerPreview(PreviewSampleData.inMemoryContainer) {
    VStack {
//      PostCell(post: Post.smallText, isCommentView: false)
//      PostCell(post: Post.mediumText, isCommentView: false)
//      PostCell(post: Post.longText, isCommentView: false)
//      PostCell(post: Post.link, isCommentView: false)
      PostCell(post: Post.formattedText, isCommentView: true)
    }.padding()
  }
}
