//
// Copyright (c) 2023 - Present Cory Ginsberg
// Licensed under Apache License 2.0
//

import FaviconFinder
import Foundation

@Observable
final class FaviconLoaderViewModel: LoadableItemState<FaviconImage>, LoadableItem {
  typealias TLoadFrom = URL
  func load(from url: TLoadFrom, isPreview: Bool = false) async {
    state = .loading
    do {
      let favicon = try await FaviconFinder(url: url).fetchFaviconURLs().download().largest()
      if let image = favicon.image {
        state = .loaded(image)
      } else {
        state = .failed(FaviconError.emptyFavicon)
      }
    } catch {
      state = .failed(error)
    }
  }
}
