//
// Copyright (c) 2023 - Present Cory Ginsberg
// Licensed under Apache License 2.0
//

import Foundation
import OSLog

private let logger = Logger(subsystem: Bundle.main.bundleIdentifier ?? "", category: "fetching")

enum ItemFetcher {
  static func fetch<T: Decodable>(fromUrl url: URL?) async throws -> T {
    guard let url, // Why the f*ck is URL.init() optional??? Don't return nil, throw!
          let (data, response) = try? await URLSession.shared.data(from: url),
          let httpResponse = response as? HTTPURLResponse,
          httpResponse.statusCode == 200
    else {
      throw FetchResultsError.DownloadError.missingData
    }
    logger.info("HTTP Response \(httpResponse.statusCode). Pulling from url: \(url)")

    do {
      // Decode the JSON into a data model
      let jsonDecoder = JSONDecoder()
      jsonDecoder.dateDecodingStrategy = .iso8601
      return try jsonDecoder.decode(T.self, from: data)
    } catch {
      logger.error("\(error)")
      throw FetchResultsError.DownloadError.wrongDataFormat(error: error)
    }
  }
}
