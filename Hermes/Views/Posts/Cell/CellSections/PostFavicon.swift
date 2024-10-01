//
// Copyright (c) 2023 - Present Cory Ginsberg
// Licensed under Apache License 2.0
//

import NukeUI
import SwiftUI

struct PostFavicon: View {
  @Binding var post: Post

  @State private var loadUrl = false
  @State private var url: URL?

  private let faviconLoader = FaviconLoaderViewModel()

  var body: some View {
    ZStack {
      LazyImage(url: url,
                transaction: .init(animation: .easeInOut)) { state in
        if let image = state.image {
          image.resizable().aspectRatio(contentMode: .fill)
        } else if state.error != nil {
          Image(systemName: "\(post.siteDomain?.first ?? "a").square.fill")
            .faviconStyle()
            .foregroundStyle(.accent, .thickMaterial)
        } else {
          Image(systemName: "square.fill")
            .faviconStyle()
            .foregroundStyle(.thickMaterial)
        }
      }
      .processors([.resize(size: CGSize(width: 100, height: 100),
                           contentMode: .aspectFit,
                           upscale: true)])
      .priority(.high)
      .faviconStyle()
      PostFaviconProfileIcon(faviconUrl: $url, sourceDomain: $post.siteDomain)
    }
    .task {
      if let url = URL(string: self.post.siteDomain ?? "") {
        self.url = await self.faviconLoader.load(from: url)
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
      .background(.thinMaterial)
      .clipShape(RoundedRectangle(cornerRadius: 8))
  }
}

extension Image {
  @ViewBuilder
  func faviconStyle() -> some View {
    resizable().modifier(PreviewImageViewModifier())
  }
}

extension LazyImage {
  @ViewBuilder
  func faviconStyle() -> some View {
    modifier(PreviewImageViewModifier())
  }
}

extension ProgressView {
  @ViewBuilder
  func faviconStyle() -> some View {
    modifier(PreviewImageViewModifier())
  }
}
