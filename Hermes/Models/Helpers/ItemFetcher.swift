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
      // /search/ uses the standard ISO8601 date format but /items/ uses ISO8601 with fractional seconds for some reason
//      jsonDecoder.dateDecodingStrategy = .custom { decoder -> Date in
//        let container = try decoder.singleValueContainer()
//        guard let containerString = try? container.decode(String.self) else {
//          return Date.now
//        }
//        let formatter1 = ISO8601DateFormatter()
//        formatter1.formatOptions = .withInternetDateTime
//        let formatter2 = ISO8601DateFormatter()
//        formatter2.formatOptions = [.withInternetDateTime, .withFractionalSeconds]
//        if let date = formatter1.date(from: containerString) {
//          return date
//        } else if let date = formatter2.date(from: containerString) {
//          return date
//        }
//        throw DecodingError.dataCorruptedError(in: container,
//                                               debugDescription: "Invalid date string: \(containerString)")
//      }
      return try jsonDecoder.decode(T.self, from: data)
    } catch {
      logger.error("\(error)")
      throw FetchResultsError.DownloadError.wrongDataFormat(error: error)
    }
  }
}

// MARK: - FetchResultsError enum

enum FetchResultsError: Error {
  /// Errors on the query request itself
  enum QueryError: Error {
    case noSearchCriteria
    case notInStoryList
  }

  /// Errors that occur when loading feature data
  enum DownloadError: Error {
    case wrongDataFormat(error: Error)
    case missingData
  }
}
