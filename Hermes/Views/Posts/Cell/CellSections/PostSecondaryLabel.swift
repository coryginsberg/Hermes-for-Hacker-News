//
// Copyright (c) 2023 - Present Cory Ginsberg
// Licensed under Apache License 2.0
//

import SwiftUI

// MARK: - PostSecondaryLabelView

struct PostSecondaryLabel: View {
  var post: Post
  var textColor: Color

  var body: some View {
    ViewThatFits(in: .horizontal) {
      HStack(spacing: 4.0) {
        Group {
          SecondaryInfoButton(
            systemImage: "arrow.up",
            textBody: "\(post.score)"
          ) {}
          SecondaryInfoButton(
            systemImage: "bubble.left",
            textBody: "\(post.numComments)"
          ) {}
          SecondaryInfoButton(
            systemImage: "clock",
            textBody: DateFormatter
              .calcTimeSince(datePosted: post.createdAt)
          ) {}
        }
        .padding(.trailing, 10.0)
        .frame(alignment: .leading)
        AuthorText(author: post.author)
      }
      .padding(.bottom, 2.0)
    }
  }
}
