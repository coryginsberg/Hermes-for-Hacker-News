//
// Copyright (c) 2023 - Present Cory Ginsberg
// Licensed under Apache License 2.0
//

// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let hNSearchResults = try? JSONDecoder().decode(HNSearchResults.self, from: jsonData)

import Foundation
import OSLog

// MARK: - AngoliaSearchResults

struct AngoliaSearchResults: Codable {
  var hits: [Hit]
  var hitsPerPage: Int
  var nbHits: Int
  var nbPages: Int
  var page: Int
  var params: String
  var processingTimeMs: Int
  var query: String
  var serverTimeMs: Int

  enum CodingKeys: String, CodingKey {
    case hits
    case hitsPerPage
    case nbHits
    case nbPages
    case page
    case params
    case processingTimeMs = "processingTimeMS"
    case query
    case serverTimeMs = "serverTimeMS"
  }

  // MARK: - Hit

  struct Hit: Codable {
    var tags: [String]
    var author: String
    var children: [Int]
    var createdAt: Date
    var jobText: String?
    var numComments: Int
    var objectId: String
    var points: Int
    var title: String
    var updatedAt: Date
    var url: String?
    var storyText: String?

    // swiftlint:disable nesting
    enum CodingKeys: String, CodingKey {
      case tags = "_tags"
      case author
      case children
      case createdAt = "created_at"
      case jobText = "job_text"
      case numComments = "num_comments"
      case objectId = "objectID"
      case points
      case title
      case updatedAt = "updated_at"
      case url
      case storyText = "story_text"
    }
    // swiftlint:enable nesting
  }
}

extension AngoliaSearchResults.Hit: CustomStringConvertible {
  var description: String {
    """
    hit: {
      author: \(author),
      children: \(String(describing: children)),
      createdAt: \(String(describing: createdAt)),
      numComments: \(String(describing: numComments))
      points: \(String(describing: points))
      title: \(String(describing: title))
      url: \(String(describing: url))
      updatedAt: \(String(describing: updatedAt))
      storyText: \(String(describing: storyText))
      jobText: \(String(describing: jobText))
      objectId: \(String(describing: objectId))
    }
    """
  }
}

extension AngoliaSearchResults: CustomStringConvertible {
  var description: String {
    var description = "Empty search result"
    if let hit = hits.first {
      description = hit.description
      if hits.count > 1 {
        description += "\n...and \(hits.count - 1) more."
      }
    }
    return description
  }
}

// MARK: - Init & Fetching

extension AngoliaSearchResults {
  init(data: Data) throws {
    self = try JSONDecoder().decode(AngoliaSearchResults.self, from: data)
  }

  init(_ json: String, using encoding: String.Encoding = .utf8) throws {
    guard let data = json.data(using: encoding) else {
      throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
    }
    try self.init(data: data)
  }

  init(fromURL url: URL) throws {
    try self.init(data: Data(contentsOf: url))
  }

  /// Fetches results with optional parameters
  ///
  /// By default a limited number of results are returned in each page, so a given query may be broken over dozens of
  /// pages. The number of results and page number are available as the variables `nbPages` and `hitsPerPage`
  /// respectively; they can be specified as arguments in requests, allowing for more results to be requested or
  /// iteration over the available pages eg appending to the search URL parameters like `&page=2` or `hitsPerPage=50`.
  ///
  /// The complete list of search parameters is available in
  /// [Algolia Search API documentation](https://www.algolia.com/doc/rest-api/search/#QueryIndex).
  ///
  /// - Parameters:
  ///   - tags: filter on a specific tag. Tags are ANDed by default, can be ORed if between parenthesis. For example
  ///           `author_pg,(story,poll)` filters on `author=pg AND (type=story OR type=poll)`.
  ///   - numericFilters: filter on a specific condition (`<`, `<=`, `=`, `>`, or `>=`)
  ///   - query: full-text query
  ///   - pageNumber: page number
  ///   - hitsPerPage: number of results per page
  /// - Returns: The search results
  static func fetchResults(withTags tags: String = "",
                           query: String? = nil,
                           numericFilters: String? = nil,
                           pageNumber: Int = 0,
                           hitsPerPage: Int = 100) async throws -> AngoliaSearchResults {
    let urlBase = URL(string: C.angoliaBaseUrl)
    var urlQueryItems: [URLQueryItem] = []
    if !tags.isEmpty {
      urlQueryItems.append(.init(name: "tags", value: tags))
    }
    if query != nil && query?.isEmpty == false {
      urlQueryItems.append(.init(name: "query", value: query))
    }
    guard !urlQueryItems.isEmpty else {
      throw FetchResultsError.QueryError.noSearchCriteria
    }

    let fullSearchUrl = urlBase?.appending(queryItems: urlQueryItems)
      .appending(queryItems: ["hitsPerPage": hitsPerPage, "page": pageNumber]
        .map { key, value -> URLQueryItem in
          URLQueryItem(name: key, value: String(value))
        })
    Logger(category: "AngoliaSearchResults").log("\(fullSearchUrl?.absoluteString ?? "")")

    return try await ItemFetcher.fetch(fromUrl: fullSearchUrl)
  }

  static func fetchStoryList(list: HNStoriesList.StoryLists) async throws -> (AngoliaSearchResults, HNStoriesList) {
    let storyList = try await HNStoriesList.fetch(withStoryList: list)
    var charCount = C.angoliaBaseUrl.count + C.urlSizeBreathingRoom
    let storiesAsUrlTags = storyList.compactMap { story in
      let storyText = "story_\(story)"
      charCount = charCount + storyText.count + 1 // + 1 for the comma separator
      guard charCount <= C.maxRequestChars else {
        return nil
      }
      return storyText
    }.joined(separator: ",")
    return try (await fetchResults(withTags: "story,(\(storiesAsUrlTags))"), storyList)
  }
}
