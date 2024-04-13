//
// Copyright (c) 2023 - Present Cory Ginsberg
// Licensed under Apache License 2.0
//

import DomainParser
import SwiftUI

// MARK: - PostPrimaryLabelView

struct PostPrimaryLabel: View {
  @State private var showSafari: Bool = false

  var post: Post
  var secondaryTextColor: Color
  var isCommentView: Bool = false

  var body: some View {
    if isCommentView, let url = post.url {
      PrimaryLabel(post: post, secondaryTextColor: secondaryTextColor)
        .onTapGesture {
          showSafari.toggle()
        }.fullScreenCover(isPresented: $showSafari, content: {
          WebViewWrapper(url: url)
        })
    } else {
//      NavigationLink(destination: CommentListView(currentPost: postData)) {
      PrimaryLabel(post: post, secondaryTextColor: secondaryTextColor)
//      }
    }
  }
}

// MARK: - PrimaryLabel

struct PrimaryLabel: View {
  var post: Post
  var secondaryTextColor: Color

  var body: some View {
    VStack(alignment: .leading) {
      Text(post.title)
        .foregroundColor(Color(uiColor: .label))
        .multilineTextAlignment(.leading)
        .allowsTightening(true)
        .frame(maxWidth: .infinity, alignment: .leading)
        .font(.headline)
        .fontWeight(.regular)
      if let url = post.url {
        Text(url.domain ?? "")
          .font(.footnote)
          .frame(maxWidth: .infinity, alignment: .topLeading)
          .padding(.top, 0.0)
          .foregroundColor(.init(uiColor: .tertiaryLabel))
      }
    }
    .padding(.bottom, 8.0)
  }
}
