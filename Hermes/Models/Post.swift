//
// Copyright (c) 2023 - Present Cory Ginsberg
// Licensed under Apache License 2.0
//

import Foundation
import SwiftData

@Model
class Post {
  #Unique<Post>([\.itemId], [\.rank])

  var rank: Int
  var itemId: HNID
  var author: Author
  var createdAt: Date
  var numComments: Int?
  var score: Int
  var title: String
  var url: URL?
  var siteDomain: String?
  @Attribute(.preserveValueOnDeletion) var viewed: Bool
  var isHidden: Bool = false

  init(
    rank: Int,
    itemId: HNID,
    author: Author,
    createdAt: Date,
    numComments: Int,
    score: Int,
    title: String,
    url: URL? = nil,
    siteDomain: String? = nil,
    isHidden: Bool = false
  ) {
    self.rank = rank
    self.itemId = itemId
    self.author = author
    self.createdAt = createdAt
    self.numComments = numComments
    self.score = score
    self.title = title
    self.url = url
    self.siteDomain = siteDomain
    self.isHidden = isHidden
    self.viewed = Post.isPostViewed(forHNID: itemId)
  }
}

extension Post {
  static func isPostViewed(forHNID postId: HNID) -> Bool {
    let viewedPosts = UserDefaults.standard.array(forKey: UserDefaultKeys.viewedPosts.rawValue)
    print(viewedPosts ?? "nil")
    if let viewedPosts = viewedPosts as? [HNID] {
      return viewedPosts.containsItem(postId)
    } else {
      UserDefaults.standard.set([HNID](), forKey: UserDefaultKeys.viewedPosts.rawValue)
      return false
    }
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

extension Array where Element == HNID {
  func containsItem(_ id: HNID) -> Bool {
    contains { $0 == id }
  }
}
