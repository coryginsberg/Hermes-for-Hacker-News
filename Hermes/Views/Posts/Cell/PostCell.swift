//
// Copyright (c) 2023 - Present Cory Ginsberg
// Licensed under Apache License 2.0
//

import SwiftData
import SwiftUI

// MARK: - PostCellOuter

struct PostCell: View {
  @State var post: Post
  @State var isCommentView: Bool = false
  @Default(.viewedPosts) var viewedPosts

  let secondaryTextColor = Color(uiColor: .secondaryLabel)

  var body: some View {
    // Non-lazy VStack cuts off divider line for some reason
    LazyVStack(alignment: .leading) {
      HStack(alignment: .top) {
        if post.url != nil && post.siteDomain != nil {
          PostFavicon(post: $post)
        }
        VStack {
          PostText(
            post: post,
            isCommentView: isCommentView
          )
          if isCommentView {
            TextBlockView(text: post.title)
          }
          PostSecondaryLabel(post: post, textColor: secondaryTextColor)
        }.opacity(viewedPosts.contains(post.itemId) && !isCommentView ? 0.5 : 1)
      }
      if isCommentView {
        Divider()
      }
    }
  }
}

#Preview("Front Page", traits: .modifier(SamplePostListData())) {
  @Previewable @Query var posts: [Post]
  VStack {
    ForEach(posts) { post in
      PostCell(post: post, isCommentView: false)
    }
  }.padding()
}
