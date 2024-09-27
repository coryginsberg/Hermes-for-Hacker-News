//
// Copyright (c) 2023 - Present Cory Ginsberg
// Licensed under Apache License 2.0
//

import Foundation
import Nuke

@Observable
final class FaviconLoaderViewModel: LoadableItemState<PlatformImage>, LoadableItem, @unchecked Sendable {
  typealias TLoadFrom = URL

  let defaultURL: URL = .init(staticString: "https://www.faviconextractor.com/favicon/")

  func load(from url: TLoadFrom, isPreview: Bool = false) async {
    state = .loading
    await Slog.log(.debug, message: "Loading favicon for \(url)")
    do {
      let urlToLoad = await genImageToLoad(fromUrl: url)
      let request = ImageRequest(url: urlToLoad,
                                 processors: [.resize(size: CGSize(width: 50, height: 50),
                                                      contentMode: .aspectFit,
                                                      upscale: true)],
                                 priority: .high)
      let image = try await ImagePipeline.shared.imageTask(with: request).image
      state = .loaded(image)
    } catch {
      state = .failed(.loadingError)
      await Slog.error(error, message: "URL: \(url)")
    }
  }

  private func genImageToLoad(fromUrl url: URL) async -> URL {
    switch await url.domain {
    case "github.com":
      return genGitHubImageUrl(fromUrl: url)
    default:
      return defaultURL.appending(path: url.absoluteString)
    }
  }
}

extension FaviconLoaderViewModel {
  private func genGitHubImageUrl(fromUrl url: URL) -> URL {
    return URL(staticString: "https://github.com/favicon.ico")
  }
}

extension FaviconLoaderViewModel: Logging {}
