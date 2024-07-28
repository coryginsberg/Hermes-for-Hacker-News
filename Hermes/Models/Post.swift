//
// Copyright (c) 2023 - Present Cory Ginsberg
// Licensed under Apache License 2.0
//

import Foundation
import SwiftData

@Model
final class Post {
  var itemId: HNID
  var author: Author
  var createdAt: String
  var numComments: Int?
  var score: Int
  var title: String
  var url: URL?

  init(
    itemId: HNID,
    author: Author,
    createdAt: String,
    numComments: Int? = nil,
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
