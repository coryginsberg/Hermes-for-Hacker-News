//
// Copyright (c) 2024 Cory Ginsberg.
// Licensed under the Apache License, Version 2.0
//

import SwiftUI

// MARK: - PostCellOuter

struct PostCellOuterView: View {
  @State var postData: PostData
  @State var isCommentView: Bool = false

  let secondaryTextColor = Color(uiColor: .secondaryLabel)
  let spacer = Spacer(minLength: 4.0)

  init(postData: PostData, isCommentView: Bool = false) {
    self.postData = postData
    self.isCommentView = isCommentView
    #if targetEnvironment(simulator) && DEBUG
      print(postData.title as Any, postData.id)
    #endif
  }

  var body: some View {
    LazyVStack(alignment: .leading) {
      Grid(alignment: .leading) {
        GridRow {
          if postData.type == .story, let url = postData.url {
            PostFaviconView(url: url)
          }
          PostCellTextView(postData: postData, isCommentView: isCommentView)
        }
        GeometryReader { geometry in
          Divider()
            .frame(width: abs(geometry.size.width - 32))
            .padding(.horizontal, 16.0)
        }
      }.fixedSize(horizontal: false, vertical: true)
    }
  }
}

#Preview {
  PostCellOuterView(postData: TestData.Posts.randomPosts[0])
}
