//
// Copyright (c) 2023 - Present Cory Ginsberg
// Licensed under Apache License 2.0
//

import SwiftUI

struct PostFavicon: View {
  @Binding var post: Post

  @State private var loadUrl = false

  private let faviconLoader = FaviconLoaderViewModel()

  var body: some View {
    Group {
      switch self.faviconLoader.state {
      case .loading:
        ProgressView()
          .faviconStyle()
      case .loaded(let url):
        Image(uiImage: url).faviconStyle()
      case .failed:
        Image(.awkwardMonkey)
          .faviconStyle()
          .redacted(reason: .invalidated)
      default:
        Image(.awkwardMonkey)
          .faviconStyle()
          .redacted(reason: .invalidated)
      }
    }.task {
      if let url = URL(string: self.post.siteDomain ?? "") {
        await self.faviconLoader.load(from: url)
      }
    }
    .onTapGesture {
      self.loadUrl.toggle()
    }
    .fullScreenCover(isPresented: $loadUrl) {
      if let url = self.post.url {
        WebViewWrapper(url: url)
      }
    }.padding(.trailing, 16)
  }
}

extension PostFavicon: Logging {}

private struct PreviewImageViewModifier: ViewModifier {
  func body(content: Content) -> some View {
    content
      .scaledToFit()
      .transition(.scale(scale: 0.1, anchor: .center))
      .frame(width: 50, height: 50, alignment: .top)
      .clipShape(RoundedRectangle(cornerRadius: 8))
  }
}

extension Image {
  @ViewBuilder
  func faviconStyle() -> some View {
    resizable().modifier(PreviewImageViewModifier())
  }
}

extension ProgressView {
  @ViewBuilder
  func faviconStyle() -> some View {
    modifier(PreviewImageViewModifier())
  }
}
