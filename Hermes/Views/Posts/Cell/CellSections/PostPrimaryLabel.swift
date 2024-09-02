//
// Copyright (c) 2023 - Present Cory Ginsberg
// Licensed under Apache License 2.0
//

import DomainParser
import SwiftUI

// MARK: - PrimaryLabel

struct PrimaryLabel: View {
  @Binding var post: Post
  @Binding var isCommentView: Bool

  var body: some View {
    if isCommentView, let url = post.url {
      label.modifier(PrimaryLabelLink(url: url))
    } else {
      label
    }
  }

  var label: some View {
    VStack(alignment: .leading) {
      Text(post.title).primaryLabel(withCommentView: $isCommentView)
      // Show url preview if link
      if let domain = post.siteDomain {
        Text(domain).primarySublabel()
      }
    }
    .padding(.bottom, 8.0)
  }
}

private struct PrimaryLabelLink: ViewModifier {
  @State private var showSafari: Bool = false
  var url: URL

  func body(content: Content) -> some View {
    content.onTapGesture {
      showSafari.toggle()
    }.fullScreenCover(isPresented: $showSafari) {
      WebViewWrapper(url: url)
    }
  }
}

// MARK: - Primary Label Format

private struct PrimaryLabelFormat: ViewModifier {
  @Binding var isCommentView: Bool

  func body(content: Content) -> some View {
    content
      .foregroundColor(Color(uiColor: .label))
      .multilineTextAlignment(.leading)
      .allowsTightening(true)
      .frame(maxWidth: .greatestFiniteMagnitude, alignment: .leading)
      .font(.headline)
      .fontWeight(isCommentView ? .bold : .regular)
  }
}

private struct PrimarySublabelFormat: ViewModifier {
  func body(content: Content) -> some View {
    content
      .font(.footnote)
      .frame(maxWidth: .infinity, alignment: .topLeading)
      .padding(.top, 0.0)
      .foregroundColor(.init(uiColor: .tertiaryLabel))
  }
}

public extension View {
  @ViewBuilder
  func primaryLabel(withCommentView isCommentView: Binding<Bool>) -> some View {
    modifier(PrimaryLabelFormat(isCommentView: isCommentView))
  }

  @ViewBuilder
  func primarySublabel() -> some View {
    modifier(PrimarySublabelFormat())
  }
}
