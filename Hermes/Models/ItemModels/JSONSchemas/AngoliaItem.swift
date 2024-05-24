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

// MARK: - Item

struct AngoliaItem: Decodable {
  var author: String
  var children: [AngoliaItem]
  var createdAt: String
  var id: Int
  var parentId: Int?
  var points: Int?
  var storyId: Int
  var text: String
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

extension AngoliaItem {
  init(data: Data) throws {
    self = try JSONDecoder().decode(AngoliaItem.self, from: data)
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

  /// Fetches a single item by HNID
  ///
  /// - Parameters:
  ///    - id: The HNID of the item to fetch
  ///
  /// - Returns: The item with the given HNIDResponseSerializer
  static func fetchItem(by id: HNID) async throws -> AngoliaItem {
    if let url = URL(string: "https://hn.algolia.com/api/v1/items/\(id)") {
      let temp = await AF.request(url).serializingDecodable(AngoliaItem.self).result
      print(temp)
      return try temp.get()
    }
    throw URLError(.badURL)
//    Logger(category: "AngoliaItem").log("\(url?.absoluteString ?? "")")
//    return try await ItemFetcher.fetch(fromUrl: url)
  }
}

// MARK: - Alamofire response handlers

extension DataRequest {
//  fileprivate func decodableResponseSerializer<T: Decodable>() -> DecodableResponseSerializer<T> {
//    return DecodableResponseSerializer
//    return DataResponseSerializer { _, _, data, error in
//      guard error == nil else { return .failure(error!) }
//
//      guard let data = data else {
//        return .failure(AFError.responseSerializationFailed(reason: .inputDataNil))
//      }
//
//      return Result { try JSONDecoder().decode(T.self, from: data) }
//    }
//  }
//
//  @discardableResult
//  fileprivate func responseDecodable<T: Decodable>(queue: DispatchQueue = .main, completionHandler: @escaping (DataResponse<T, AFError>) -> Void) -> Self {
//    let decodableResponseSerializer = DecodableResponseSerializer<T>.decodable(of: AngoliaItem(data: T))
//    return response(queue: queue, responseSerializer: decodableResponseSerializer, completionHandler: completionHandler)
//  }
//
//  @discardableResult
//  func responseAngoliaItem(queue: DispatchQueue = .main, completionHandler: @escaping (DataResponse<AngoliaItem, AFError>) -> Void) -> Self {
//    return DecodableResponseSerializer().serialize(request: request, response: response, data: data, error: error)
//    return responseDecodable(queue: queue, completionHandler: completionHandler)
//  }
}
