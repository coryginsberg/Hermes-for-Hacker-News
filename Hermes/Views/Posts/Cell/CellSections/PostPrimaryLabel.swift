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
  var isCommentView: Bool = false

  var body: some View {
    PrimaryLabel(post: post, isCommentView: isCommentView)
      .if(isCommentView && post.url != nil) { label in
        label
          .onTapGesture {
            showSafari.toggle()
          }.fullScreenCover(isPresented: $showSafari, content: {
            WebViewWrapper(url: post.url.unsafelyUnwrapped)
          })
      }
  }
}

// MARK: - PrimaryLabel

struct PrimaryLabel: View {
  var post: Post
  var isCommentView: Bool

  var body: some View {
    VStack(alignment: .leading) {
      Text(post.title)
        .foregroundColor(Color(uiColor: .label))
        .multilineTextAlignment(.leading)
        .allowsTightening(true)
        .frame(maxWidth: .greatestFiniteMagnitude, alignment: .leading)
        .font(.headline)
        .if(isCommentView) { text in
          text.fontWeight(.bold)
        }

      // Show url preview if link
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

#Preview("Comment View") {
  ModelContainerPreview(PreviewSampleData.inMemoryContainer) {
    VStack {
      PostText(post: Post.formattedText, isCommentView: true, isFaviconVisible: false)
    }.padding()
  }
}
