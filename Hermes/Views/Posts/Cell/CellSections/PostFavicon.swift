//
// Copyright (c) 2023 - Present Cory Ginsberg
// Licensed under Apache License 2.0
//

import FaviconFinder
import NukeUI
import SwiftUI

struct PostFavicon: View {
  @State var url: URL
  @State var loadUrl = false

  private let faviconLoader = FaviconLoaderViewModel()

  var body: some View {
    Group {
      switch self.faviconLoader.state {
      case .loading:
        ProgressView()
          .faviconStyle()
      case .loaded(let url):
        LazyImage(request: request(ForUrl: url))
          .faviconStyle()
      case .failed(let error) where error as? FaviconError == FaviconError.failedToFindFavicon:
        Image(.awkwardMonkey)
          .faviconStyle()
          .redacted(reason: .invalidated)
      case .failed(let error) where error is FaviconError:
        Image(.awkwardMonkey)
          .faviconStyle()
          .redacted(reason: .invalidated)
          .onAppear {
            LogError(error, message: "Favicon error:")
          }
      case .failed(let error):
        Image(.awkwardMonkey)
          .faviconStyle()
          .redacted(reason: .invalidated)
          .onAppear {
            LogError(error)
          }
      default:
        Image(.awkwardMonkey)
          .faviconStyle()
          .redacted(reason: .invalidated)
      }
    }.task {
      await self.faviconLoader.load(from: self.url)
    }
    .onTapGesture {
      self.loadUrl.toggle()
    }
    .fullScreenCover(isPresented: $loadUrl) {
      WebViewWrapper(url: self.$url.wrappedValue)
    }.padding(.trailing, 16)
  }
}

extension PostFavicon {
  func request(ForUrl url: URL) -> ImageRequest {
    return ImageRequest(url: url,
                        processors: [
                          .resize(height: 100),
                          .resize(width: 100)
                        ],
                        priority: .high)
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

// FaviconLoader typealiases Image so we need to specify here
extension SwiftUI.Image {
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
