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
        SecondaryImage(imageName: "arrow.up", textColor: textColor)
        SecondaryText(textBody: "\(postData?.score ?? 0)", textColor: textColor)
        SecondaryImage(imageName: "bubble.left", textColor: textColor)
        SecondaryText(
          textBody: "\(postData?.descendants ?? 0)",
          textColor: textColor
        )
        Image(systemName: "clock")
          .dynamicTypeSize(.xSmall)
          .foregroundColor(textColor)
        SecondaryText(
          textBody: ItemInfoHelper
            .calcTimeSince(datePosted: postData?.time ?? Date()),
          textColor: textColor
        )
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

// MARK: - SecondaryImage

struct SecondaryImage: View {
  let imageName: String
  let textColor: Color

  var body: some View {
    Image(systemName: imageName)
      .font(.caption)
      .foregroundColor(.init(uiColor: .secondaryLabel))
  }
}

// MARK: - SecondaryText

struct SecondaryText: View {
  var textBody: String
  var textColor: Color

  var body: some View {
    Text(textBody)
      .foregroundColor(textColor)
      .font(.system(size: 12))
      .padding(.trailing, 6.0)
      .lineLimit(1)
  }
}

#Preview {
  PostCellOuterView(postData: TestData.Posts.randomPosts[0])
}
