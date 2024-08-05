//
// Copyright (c) 2023 - Present Cory Ginsberg
// Licensed under Apache License 2.0
//

@preconcurrency import FaviconFinder
import Foundation

final class FaviconLoaderViewModel: LoadableItemState<FaviconImage>, LoadableItem {
  typealias TLoadFrom = URL
  func load(from url: TLoadFrom, isPreview: Bool = false) async {
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
