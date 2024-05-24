//
// Copyright (c) 2023 - Present Cory Ginsberg
// Licensed under Apache License 2.0
//

import Foundation
import SwiftData

/// Post with Comments to be used on the comments view itself.
@Model
final class PostWithComments {
  @Attribute(.unique) var itemId: HNID
  var author: String
  @Relationship(deleteRule: .cascade, inverse: \Comment.post) var children: [Comment]
  var createdAt: String
  var points: Int?
  var title: String
  var url: URL?
  var text: String?

  init(postId: HNID,
       author: String,
       children: [Comment]?,
       createdAt: String,
       points: Int?,
       title: String,
       url: String?, // Pass in string, converted to URL
       text: String?) {
    self.itemId = postId
    self.author = author
    self.children = children ?? []
    self.createdAt = createdAt
    self.points = points
    self.title = title
    self.url = URL(string: url ?? "")
    self.text = text
  }
}

extension PostWithComments: CustomStringConvertible {
  var description: String {
    "\(itemId), \(title) by \(author) with \(children.count) comments"
  }
}

// A convenience for accessing a post in an array by its identifier
extension Array where Element: PostWithComments {
  /// Gets the first post in the array with the specified ID, if any
  subscript(id: PostWithComments.ID?) -> PostWithComments? {
    first { $0.id == id }
  }
}

// Ensure that the model's conformance to Identifiable is public
extension PostWithComments: Identifiable {}

// MARK: - Convenience Inits

extension PostWithComments {
  convenience init(from postId: HNID) async throws {
    let post = try await AngoliaItem.fetchItem(by: postId)
    try await self.init(from: post)
  }

  convenience init(from post: AngoliaItem) async throws {
    guard let title = post.title else {
      throw GenericError.missingValue("PostWithComments must have a title")
    }

    let children = await post.children.asyncCompactMap { child in
      do {
        return try await Comment(from: child, commentDepth: 0)
      } catch {
        return nil
      }
    }

    self.init(postId: post.storyId,
              author: post.author,
              children: children,
              createdAt: post.createdAt,
              points: post.points,
              title: title,
              url: post.url,
              text: post.text)
  }
}
