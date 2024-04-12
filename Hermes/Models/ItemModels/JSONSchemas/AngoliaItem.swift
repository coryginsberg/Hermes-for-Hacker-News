//
//  AngoliaItem.swift
//  Hermes
//
//  Created by Cory Ginsberg on 4/12/24.
//

import Foundation

// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let item = try? newJSONDecoder().decode(Item.self, from: jsonData)

// MARK: - Item

struct AngoliaItem: Codable {
  var author: String
  var children: [AngoliaItem]
  var createdAt: Date
  var id: Int
  var parentId: Int?
  var points: Int?
  var storyId: Int
  var text: String
  var title: String?
  var type: TypeEnum
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

enum TypeEnum: String, Codable {
  case comment
  case story
}
