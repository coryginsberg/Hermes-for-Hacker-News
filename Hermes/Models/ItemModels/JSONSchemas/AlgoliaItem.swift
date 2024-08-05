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
      jsonDecoder.dateDecodingStrategy = .iso8601withFractionalSeconds

      let result = await AF.request(url).serializingDecodable(AlgoliaItem.self, decoder: jsonDecoder).result
      return try result.get()
    }
    throw URLError(.badURL)
  }
}

extension Date.ISO8601FormatStyle {
  static let iso8601withFractionalSeconds: Self = .init(includingFractionalSeconds: true)
}

extension ParseStrategy where Self == Date.ISO8601FormatStyle {
  static var iso8601withFractionalSeconds: Date.ISO8601FormatStyle { .iso8601withFractionalSeconds }
}

extension FormatStyle where Self == Date.ISO8601FormatStyle {
  static var iso8601withFractionalSeconds: Date.ISO8601FormatStyle { .iso8601withFractionalSeconds }
}

extension Date {
  init(iso8601withFractionalSeconds parseInput: ParseStrategy.ParseInput) throws {
    try self.init(parseInput, strategy: .iso8601withFractionalSeconds)
  }

  var iso8601withFractionalSeconds: String {
    formatted(.iso8601withFractionalSeconds)
  }
}

extension String {
  func iso8601withFractionalSeconds() throws -> Date {
    try .init(iso8601withFractionalSeconds: self)
  }
}

extension JSONDecoder.DateDecodingStrategy {
  static let iso8601withFractionalSeconds = custom {
    do {
      return try .init(iso8601withFractionalSeconds: $0.singleValueContainer().decode(String.self))
    } catch {
      return try .init($0.singleValueContainer().decode(String.self), strategy: .iso8601)
    }
  }
}
