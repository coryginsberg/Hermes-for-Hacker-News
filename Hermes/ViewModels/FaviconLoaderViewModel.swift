//
// Copyright (c) 2023 - Present Cory Ginsberg
// Licensed under Apache License 2.0
//

import FaviconFinder
import Foundation

@Observable
final class FaviconLoaderViewModel: LoadableItemState<URL>, LoadableItem, @unchecked Sendable {
  typealias TLoadFrom = URL
  func load(from url: TLoadFrom, isPreview: Bool = false) async {
    state = .loading
    do {
      guard let faviconUrl = try await FaviconFinder(url: url).fetchFaviconURLs().first?.source else {
        state = .failed(FaviconError.emptyFavicon)
        return
      }
      state = .loaded(faviconUrl)
    } catch {
      state = .failed(error)
    }
  }
}
