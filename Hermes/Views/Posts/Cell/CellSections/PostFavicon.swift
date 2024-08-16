//
// Copyright (c) 2023 - Present Cory Ginsberg
// Licensed under Apache License 2.0
//

import FaviconFinder
import SwiftUI

struct PostFavicon: View {
  @State var data: Data
  @State var loadUrl = false

  private let faviconLoader = FaviconLoaderViewModel()

  var body: some View {
    VStack {
      Image(uiImage: UIImage(data: self.data) ?? UIImage())
//      switch self.faviconLoader.state {
//      case .loading:
//        ProgressView()
//          .faviconStyle(withUrlToLoad: self.$url)
//      case .loaded(let image):
//        Image(uiImage: image.image)
//          .faviconStyle(withUrlToLoad: self.$url)
//      case .failed(let error) where error as? FaviconError == FaviconError.failedToFindFavicon:
//        Image(.awkwardMonkey)
//          .faviconStyle(withUrlToLoad: self.$url)
//          .redacted(reason: .invalidated)
//      case .failed(let error) where error is FaviconError:
//        Image(.awkwardMonkey)
//          .faviconStyle(withUrlToLoad: self.$url)
//          .redacted(reason: .invalidated)
//          .onAppear {
//            LogError(error, message: "Favicon error:")
//          }
//      case .failed(let error):
//        Image(.awkwardMonkey)
//          .faviconStyle(withUrlToLoad: self.$url)
//          .redacted(reason: .invalidated)
//          .onAppear {
//            LogError(error)
//          }
//      default:
//        Image(.awkwardMonkey)
//          .faviconStyle(withUrlToLoad: self.$url)
//          .redacted(reason: .invalidated)
//      }
    }
    .onTapGesture {
      self.loadUrl.toggle()
    }
//    .fullScreenCover(isPresented: self.$loadUrl) {
//      WebViewWrapper(url: self.$url.wrappedValue)
//    }
  }
}

extension PostFavicon: Logging {}

// FaviconLoader typealiases Image so we need to specify here
extension SwiftUI.Image {
  func faviconStyle() -> some View {
    return self.resizable()
      .scaledToFit()
      .transition(.scale(scale: 0.1, anchor: .center))
      .frame(width: 50, height: 50, alignment: .top)
      .clipShape(RoundedRectangle(cornerRadius: 8))
  }
}

extension ProgressView {
  func faviconStyle(withUrlToLoad url: Binding<URL>) -> some View {
    @State var loadUrl = false

    return self
      .scaledToFit()
      .transition(.scale(scale: 0.1, anchor: .center))
      .frame(width: 50, height: 50, alignment: .top)
      .clipShape(RoundedRectangle(cornerRadius: 8))
  }
}
