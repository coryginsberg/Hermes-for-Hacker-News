//
// Copyright (c) 2023 - Present Cory Ginsberg
// Licensed under Apache License 2.0
//

import Foundation
import SwiftData

@Model
class Post {
  var itemId: HNID
  var author: Author
  var createdAt: Date
  var numComments: Int?
  var score: Int
  var title: String
  var url: URL?

  init(
    itemId: HNID,
    author: Author,
    createdAt: Date,
    numComments: Int,
    score: Int,
    title: String,
    url: URL? = nil
  ) {
    self.itemId = itemId
    self.author = author
    self.createdAt = createdAt
    self.numComments = numComments
    self.score = score
    self.title = title
    self.url = url
  }
}

// A convenience for accessing a post in an array by its identifier.
extension Array where Element: Post {
  /// Gets the first post in the array with the specified ID, if any.
  subscript(id: Post.ID?) -> Post? {
    first { $0.id == id }
  }
}

// Ensure that the model's conformance to Identifiable is public.
extension Post: Identifiable {}
