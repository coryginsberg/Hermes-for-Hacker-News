//
//  Copyright (c) 2022 Cory Ginsberg.
//  Licensed under the Apache License, Version 2.0
//

import FaviconFinder
import SwiftUI

// MARK: - PostCellText

struct PostCellTextView: View {
  @State var postData: ItemData
  let secondaryTextColor = Color(uiColor: .secondaryLabel)
  let spacer: Spacer = .init(minLength: 4.0)

  var body: some View {
    VStack(alignment: .leading) {
      PostPrimaryLabelView(postData: postData, secondaryTextColor: secondaryTextColor)
      PostSecondaryLabelView(postData: postData, textColor: secondaryTextColor)
    }.padding(.horizontal, 16.0)
  }
}

#Preview {
  PostCellOuterView(postData: TestData.Posts.randomPosts[0])
}
