//
//  Comment.swift
//  Hermes
//
//  Created by Cory Ginsberg on 4/12/24.
//

import Foundation
import SwiftData

@Model
final class Comment {
  @Attribute(.unique) var itemId: Int
  var author: String
  var children: [Comment]
  var createdAt: Date
  var parentId: Int?
  var points: Int?
  var storyId: Int
  var text: String
  var depth: Int

  init(itemId: Int,
       author: String,
       children: [Comment],
       createdAt: Date,
       parentId: Int?,
       points: Int? = nil,
       storyId: Int,
       text: String,
       depth: Int = 0) {
    self.itemId = itemId
    self.author = author
    self.children = children
    self.createdAt = createdAt
    self.parentId = parentId
    self.points = points
    self.storyId = storyId
    self.text = text
    self.depth = depth
  }
}

extension Comment: CustomStringConvertible {
  var description: String {
    "\(itemId), \(text) by \(author)"
  }
}

// A convenience for accessing a post in an array by its identifier
extension Array where Element: Comment {
  /// Gets the first post in the array with the specified ID, if any
  subscript(id: Comment.ID?) -> Comment? {
    first { $0.id == id }
  }
}

// Ensure that the model's conformance to Identifiable is public
extension Comment: Identifiable {}
