//
// Copyright (c) 2023 - Present Cory Ginsberg
// Licensed under Apache License 2.0
//

import SwiftUI

struct PostFavicon: View {
  @State var url: URL
  @State var loadUrl = false

  @ObservedObject private var faviconLoader = FaviconLoaderViewModel()

  var body: some View {
    VStack {
      switch self.faviconLoader.state {
      case .loading:
        ProgressView()
          .faviconStyle(withUrlToLoad: self.$url)
      case .loaded(let image):
        Image(uiImage: image)
          .faviconStyle(withUrlToLoad: self.$url)
      //      case .failed(let error) where error == "failedToFindFavicon":
      //        Image(.awkwardMonkey).faviconStyle(withUrlToLoad: self.$url).redacted(reason: .invalidated)
      //      case .failed(let error) where error.code == -999:
      //        Image(.awkwardMonkey).faviconStyle(withUrlToLoad: self.$url).redacted(reason: .invalidated)
      case .failed(let error):
        Image(.awkwardMonkey)
          .faviconStyle(withUrlToLoad: self.$url)
          .redacted(reason: .invalidated)
          .onAppear {
            log().error("\(error)")
          }
      default:
        Image(.awkwardMonkey)
          .faviconStyle(withUrlToLoad: self.$url)
          .redacted(reason: .invalidated)
      }
    }.task {
      await self.faviconLoader.load(from: self.url)
    }
    .onTapGesture {
      self.loadUrl.toggle()
    }
    .fullScreenCover(isPresented: self.$loadUrl) {
      WebViewWrapper(url: self.$url.wrappedValue)
    }
  }
}

extension Image {
  func faviconStyle(withUrlToLoad url: Binding<URL>) -> some View {
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
