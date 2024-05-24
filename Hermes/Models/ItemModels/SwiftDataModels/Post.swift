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
  var text: String?
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
       url: String?, // Pass in string, converted to URL
       text: String?,
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
    self.text = text
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

// MARK: - Convenience Inits

extension Post {
  convenience init(from hit: AngoliaSearchResults.Hit, index: Int = 0) throws {
    guard let objectId = Int(hit.objectId) else { throw StoryListError.objectIdNotFound }
    self.init(postId: objectId,
              tags: hit.tags,
              author: hit.author,
              children: hit.children.compactMap { $0 },
              createdAt: hit.createdAt,
              numComments: hit.numComments,
              points: hit.points,
              title: hit.title,
              updatedAt: hit.updatedAt,
              url: hit.url,
              text: hit.storyText ?? hit.jobText,
              index: index)
  }

  convenience init(from postId: HNID) async throws {
    // Fetching from search vs /items/ only pulls the IDs of comments instead of the whole
    // tree, which should cut down on loading times.
    let post = try await AngoliaSearchResults.fetchResults(withTags: "story_\(postId)")
    try self.init(from: post.hits[0])
  }
}
