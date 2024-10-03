//
// Copyright (c) 2023 - Present Cory Ginsberg
// Licensed under Apache License 2.0
//

import Alamofire
import Foundation

@Observable
final class FaviconLoaderViewModel: Sendable {
  let defaultURL: URL = .init(staticString: "https://www.faviconextractor.com/favicon/")

  func load(from url: URL) async -> URL {
    return await genImageToLoad(fromUrl: url)
  }

  private func genImageToLoad(fromUrl url: URL) async -> URL {
    switch await url.genDomain {
    case "github.com":
      return await genGitHubImageUrl(fromUrl: url)
    default:
      return defaultURL.appending(path: url.absoluteString)
    }
  }
}

extension FaviconLoaderViewModel {
  private func genGitHubImageUrl(fromUrl url: URL) async -> URL {
    let user = try? await AF.request("https://api.github.com/users/\(url.lastPathComponent)")
      .cacheResponse(using: .cache)
      .redirect(using: .doNotFollow)
      .validate()
      .serializingDecodable(GitHubUser.self)
      .result
      .get()

    if let avatarUrl = user?.avatarURL, let url = URL(string: avatarUrl) {
      return url
    }
    return URL(staticString: "https://github.com/favicon.ico")
  }
}

extension FaviconLoaderViewModel: Logging {}
