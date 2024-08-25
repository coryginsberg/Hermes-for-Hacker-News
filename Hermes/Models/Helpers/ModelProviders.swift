//
// Copyright (c) 2023 - Present Cory Ginsberg
// Licensed under Apache License 2.0
//

import Foundation

// List all model providers (protocols) here. Each model should have a
// corresponding DTO (Data Transfer Object) in order to allow use of
// actors and background tasks.

// MARK: - ItemProvider

protocol ItemProvider: AnyObject {
  var itemId: HNID { get }
}

// MARK: - PostProvider

protocol PostProvider: ItemProvider {
  associatedtype T: AuthorProvider

  var rank: Int { get }
  var author: T { get }
  var createdAt: Date { get }
  var numComments: Int { get }
  var score: Int { get }
  var title: String { get }
  var url: URL? { get }
  var siteDomain: String? { get }
  var viewed: Bool { get }
  var isHidden: Bool { get }

  init(
    rank: Int,
    itemId: HNID,
    author: T,
    createdAt: Date,
    numComments: Int,
    score: Int,
    title: String,
    url: URL?,
    siteDomain: String?,
    viewed: Bool,
    isHidden: Bool
  )
}

// MARK: - CommentProvider

protocol CommentProvider: ItemProvider {
  associatedtype T: AuthorProvider

  var author: T { get }

  init(
    itemId: HNID,
    author: T
  )
}

// MARK: - Author

// NOTE: HN Authors don't have an HNID. The username is the ID.
protocol AuthorProvider: AnyObject {
  var username: String { get }
  var color: String? { get }

  init(username: String, color: String?)
}

protocol DTO: Sendable {}
