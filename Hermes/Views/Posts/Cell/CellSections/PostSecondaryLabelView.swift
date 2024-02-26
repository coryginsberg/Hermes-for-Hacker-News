//
// Copyright (c) 2024 Cory Ginsberg.
// Licensed under the Apache License, Version 2.0
//

import SwiftUI

// MARK: - PostSecondaryLabelView

struct PostSecondaryLabelView: View {
  var postData: ItemData?
  var textColor: Color

  var body: some View {
    ViewThatFits(in: .horizontal) {
      HStack(spacing: 4.0) {
        Group {
          SecondaryInfoLabel(
            systemImage: "arrow.up",
            textBody: "\(postData?.score ?? 0)"
          )
          SecondaryInfoLabel(
            systemImage: "bubble.left",
            textBody: "\(postData?.descendants ?? 0)"
          )
          SecondaryInfoLabel(
            systemImage: "clock",
            textBody: ItemInfoHelper
              .calcTimeSince(datePosted: postData?.time ?? Date())
          )
        }.padding(.trailing, 10.0)

        Text("by \(postData?.author ?? "")")
          .allowsTightening(true)
          .frame(maxWidth: .infinity, alignment: .trailing)
          .font(.caption)
          .foregroundColor(textColor)
          .lineLimit(1)
      }
    }
  }
}

#Preview {
  PostCellOuterView(postData: TestData.Posts.randomPosts[0])
}
