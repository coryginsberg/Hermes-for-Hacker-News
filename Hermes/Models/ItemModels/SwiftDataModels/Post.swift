//
// Copyright (c) 2023 - Present Cory Ginsberg
// Licensed under Apache License 2.0
//

import Foundation
import SwiftData

@Model
final class Post {
  @Attribute(.unique) var itemId: HNID
  var tags: [String]
  var author: String
  var children: [HNID]
  var createdAt: Date
  var numComments: Int?
  var points: Int?
  var title: String
  var updatedAt: Date
  var url: URL?
  var storyText: String?
  var jobText: String?
  var index: Int

  init(postId: HNID,
       tags: [String],
       author: String,
       children: [HNID]?,
       createdAt: Date,
       numComments: Int?,
       points: Int?,
       title: String,
       updatedAt: Date,
       url: String?,
       storyText: String?,
       jobText: String?,
       index: Int) {
    self.itemId = postId
    self.tags = tags
    self.author = author
    self.children = children ?? []
    self.createdAt = createdAt
    self.numComments = numComments
    self.points = points
    self.title = title
    self.updatedAt = updatedAt
    self.url = URL(string: url ?? "")
    self.storyText = storyText
    self.jobText = jobText
    self.index = index
  }
}

extension Post: CustomStringConvertible {
  var description: String {
    "\(itemId), \(title) by \(author)"
  }
}

// A convenience for accessing a post in an array by its identifier
extension Array where Element: Post {
  /// Gets the first post in the array with the specified ID, if any
  subscript(id: Post.ID?) -> Post? {
    first { $0.id == id }
  }
}

// Ensure that the model's conformance to Identifiable is public
extension Post: Identifiable {}
