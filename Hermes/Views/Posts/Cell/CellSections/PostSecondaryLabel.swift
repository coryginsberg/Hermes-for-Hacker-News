//
// Copyright (c) 2024 Cory Ginsberg.
// Licensed under the Apache License, Version 2.0
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
          SecondaryInfoLabel(
            systemImage: "arrow.up",
            textBody: "\(post.points ?? 0)"
          )
          SecondaryInfoLabel(
            systemImage: "bubble.left",
            textBody: "\(post.numComments ?? 0)"
          )
          SecondaryInfoLabel(
            systemImage: "clock",
            textBody: DateFormatter
              .calcTimeSince(datePosted: post.createdAt)
          )
        }
        .padding(.trailing, 10.0)
        .frame(alignment: .leading)

        Text("by \(post.author)")
          .allowsTightening(true)
          .frame(maxWidth: .infinity, alignment: .trailing)
          .font(.caption)
          .foregroundColor(textColor)
          .lineLimit(1)
      }
      .padding(.bottom, 2.0)
    }
  }
}

// #Preview {
//  PostCellOuterView(postData: TestData.Posts.randomPosts[0])
// }
