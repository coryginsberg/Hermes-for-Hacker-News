//
// Copyright (c) 2023 - Present Cory Ginsberg
// Licensed under Apache License 2.0
//

import Foundation
import Nuke
import NukeUI
import UIKit

@Observable
final class FaviconLoaderViewModel: @unchecked Sendable {
  let defaultURL: URL = .init(staticString: "https://www.faviconextractor.com/favicon/")

  func load(from url: URL) async -> URL {
    return await genImageToLoad(fromUrl: url)
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
