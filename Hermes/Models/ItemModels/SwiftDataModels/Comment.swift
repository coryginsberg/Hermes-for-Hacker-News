//
// Copyright (c) 2023 - Present Cory Ginsberg
// Licensed under Apache License 2.0
//

import Foundation
import SwiftData

final class Comment {
  var itemId: HNID
  var author: String
  var children: [Comment]
  var createdAt: Date
  var parent: Comment?
  var post: Post?
  var points: Int?
  var text: String
  var commentDepth: Int

  init(itemId: HNID,
       author: String,
       children: [Comment],
       createdAt: Date,
       parent: Comment?,
       post: Post,
       points: Int? = nil,
       text: String,
       commentDepth: Int = 0) {
    self.itemId = itemId
    self.author = author
    self.children = children
    self.createdAt = createdAt
    self.parent = parent
    self.post = post
    self.points = points
    self.text = text
    self.commentDepth = commentDepth
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

// MARK: - Convenience Inits

extension Comment {
//  /// Initialize from HNID. Must provide a comment depth
//  convenience init(from id: HNID, commentDepth: Int) async throws {
//    let item = try await AlgoliaItem.fetchItem(by: id)
//    try await self.init(from: item, commentDepth: commentDepth)
//  }

  /// Initialize from an AlgoliaItem
  convenience init(from comment: AlgoliaItem, forPost post: Post, commentDepth: Int = 0) throws {
    let children = try comment.children.map { child in
      try Comment(from: child, forPost: post, commentDepth: commentDepth + 1)
    }

    let parent = if commentDepth > 0 {
      try Comment(from: comment, forPost: post, commentDepth: commentDepth - 1)
    } else {
      nil as Comment?
    }
    guard let text = comment.text?.stringByDecodingHTMLEntities.htmlToMarkDown() else {
      throw NSError(domain: "Must have text", code: 0)
    }
    self.init(itemId: comment.id,
              author: comment.author,
              children: children,
              createdAt: comment.createdAt,
              parent: parent,
              post: post,
              points: comment.points,
              text: text,
              commentDepth: commentDepth)
  }
}
