//
// Copyright (c) 2023 - Present Cory Ginsberg
// Licensed under Apache License 2.0
//

import FaviconFinder
import Foundation
import UIKit

@MainActor
final class FaviconLoaderViewModel: ObservableObject {
  enum State {
    case idle
    case loading
    case failed(Error)
    case loaded(FaviconImage)
  }

  @Published private(set) var state = State.idle

  func load(fromUrl url: URL) async {
    state = .loading
    do {
      let favicon = try await FaviconFinder(url: url, checkForMetaRefreshRedirect: true).downloadFavicon()
      DispatchQueue.main.async { [self] in
        state = .loaded(favicon.image)
      }
    } catch {
      state = .failed(error)
    }
  }
}
