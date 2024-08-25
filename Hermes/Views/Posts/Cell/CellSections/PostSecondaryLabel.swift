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
    let textColor = if let postColor = post.author.color {
      Color(postColor)
    } else {
      textColor
    }

    ViewThatFits(in: .horizontal) {
      HStack(spacing: 4.0) {
        Group {
          SecondaryInfoLabel(
            systemImage: "arrow.up",
            textBody: "\(post.score)"
          )
          SecondaryInfoLabel(
            systemImage: "bubble.left",
            textBody: "\(post.numComments)"
          )
          SecondaryInfoLabel(
            systemImage: "clock",
            textBody: DateFormatter
              .calcTimeSince(datePosted: post.createdAt)
          )
        }
        .padding(.trailing, 10.0)
        .frame(alignment: .leading)

        Text("by \(post.author.username)")
          .allowsTightening(true)
          .frame(maxWidth: .infinity, alignment: .trailing)
          .font(.caption)
          .foregroundStyle(textColor)
          .lineLimit(1)
      }
      .padding(.bottom, 2.0)
    }
  }
}

// #Preview {
//  PostCellOuterView(postData: TestData.Posts.randomPosts[0])
// }
