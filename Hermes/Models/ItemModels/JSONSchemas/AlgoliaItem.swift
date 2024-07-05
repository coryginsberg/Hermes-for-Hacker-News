//
// Copyright (c) 2023 - Present Cory Ginsberg
// Licensed under Apache License 2.0
//

// This file was generated from JSON Schema using quicktype, do not modify it directly.//
// To parse values from Alamofire responses:
//
//   Alamofire.request(url).responseAngoliaItem { response in
//     if let angoliaItem = response.result.value {
//       ...
//     }
//   }

import Alamofire
import Foundation

// MARK: - Algolia Item

struct AlgoliaItem: Decodable, Identifiable {
  var author: String
  var children: [AlgoliaItem]
  var createdAt: Date
  var id: Int
  var parentId: Int?
  var points: Int?
  var storyId: Int
  var text: String?
  var title: String?
  var type: ItemType
  var url: String?

  enum CodingKeys: String, CodingKey {
    case author
    case children
    case createdAt = "created_at"
    case id
    case parentId = "parent_id"
    case points
    case storyId = "story_id"
    case text
    case title
    case type
    case url
  }
}

enum ItemType: String, Codable {
  case comment
  case story
}

// MARK: - Init & Fetching

extension AlgoliaItem {
  init(data: Data) throws {
    self = try JSONDecoder().decode(AlgoliaItem.self, from: data)
  }

  init(fromURL url: URL) throws {
    try self.init(data: Data(contentsOf: url))
  }

  /// Fetches a single item by HNID
  ///
  /// - Parameters:
  ///    - id: The HNID of the item to fetch
  ///
  /// - Returns: The item with the given HNIDResponseSerializer
  static func fetchItem(by id: HNID) async throws -> AlgoliaItem {
    if let url = URL(string: "https://hn.algolia.com/api/v1/items/\(id)") {
      let jsonDecoder = JSONDecoder()
      jsonDecoder.dateDecodingStrategy = .iso8601WithFractionalSeconds
      let result = await AF.request(url).serializingDecodable(AlgoliaItem.self, decoder: jsonDecoder).result
      return try result.get()
    }
    throw URLError(.badURL)
  }
}

extension Formatter {
  static var standardISO8601DateFormatter: ISO8601DateFormatter = {
    let formatter = ISO8601DateFormatter()
    formatter.formatOptions = [.withInternetDateTime]
    return formatter
  }()

  static var customISO8601DateFormatter: ISO8601DateFormatter = {
    let formatter = ISO8601DateFormatter()
    formatter.formatOptions = [.withInternetDateTime, .withFractionalSeconds]
    return formatter
  }()
}

extension JSONDecoder.DateDecodingStrategy {
  static var iso8601WithFractionalSeconds = custom { decoder in
    let dateStr = try decoder.singleValueContainer().decode(String.self)
    if let date = Formatter.customISO8601DateFormatter.date(from: dateStr) {
      return date
    } else if let date = Formatter.standardISO8601DateFormatter.date(from: dateStr) {
      return date
    }
    throw DecodingError.dataCorrupted(
      DecodingError.Context(codingPath: decoder.codingPath,
                            debugDescription: "Invalid date"))
  }
}
