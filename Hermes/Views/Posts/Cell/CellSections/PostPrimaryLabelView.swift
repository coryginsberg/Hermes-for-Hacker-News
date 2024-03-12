//
// Copyright (c) 2024 Cory Ginsberg.
// Licensed under the Apache License, Version 2.0
//

import DomainParser
import SwiftUI

// MARK: - PostPrimaryLabelView

struct PostPrimaryLabelView: View {
  @State private var showSafari: Bool = false

  var postData: PostData
  var secondaryTextColor: Color
  var isCommentView: Bool = false

  var body: some View {
    if isCommentView, let url = postData.url {
      PrimaryLabel(postData: postData, secondaryTextColor: secondaryTextColor)
        .onTapGesture {
          showSafari.toggle()
        }.fullScreenCover(isPresented: $showSafari, content: {
          WebViewWrapper(url: url)
        })
    } else {
      NavigationLink(destination: CommentListView(currentPost: postData)) {
        PrimaryLabel(postData: postData, secondaryTextColor: secondaryTextColor)
      }
    }
  }
}

// MARK: - PrimaryLabel

struct PrimaryLabel: View {
  var postData: ItemData
  var secondaryTextColor: Color

  var body: some View {
    VStack(alignment: .leading) {
      Text(postData.title ?? "")
        .foregroundColor(Color(uiColor: .label))
        .multilineTextAlignment(.leading)
        .allowsTightening(true)
        .frame(maxWidth: .infinity, alignment: .leading)
        .font(.headline)
      if let url = postData.url {
        Text(url.domain ?? "")
          .font(.footnote)
          .frame(maxWidth: .infinity, alignment: .topLeading)
          .padding(.top, 0.0)
          .foregroundColor(.init(uiColor: .tertiaryLabel))
      }
    }.padding(.bottom, 8.0)
  }
}

#Preview {
  PostCellOuterView(postData: TestData.Posts.randomPosts[0])
}
