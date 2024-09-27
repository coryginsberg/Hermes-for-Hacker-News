//
// Copyright (c) 2023 - Present Cory Ginsberg
// Licensed under Apache License 2.0
//

import Foundation
import SwiftData

@Model
final class Post: PostProvider {
  #Unique<Post>([\.rank], [\.itemId])

  var rank: Int
  @Attribute(.preserveValueOnDeletion) var itemId: HNID
  var hasAuthor: Bool
  @Relationship(deleteRule: .nullify) var author: Author?
  var createdAt: Date
  var numComments: Int
  var score: Int
  var title: String
  var url: URL?
  var siteDomain: String?
  @Attribute(.preserveValueOnDeletion) var viewed: Bool
  var isHidden: Bool

  required init(
    rank: Int,
    itemId: HNID,
    hasAuthor: Bool = true,
    author: Author?,
    createdAt: Date,
    numComments: Int = 0,
    score: Int,
    title: String,
    url: URL? = nil,
    siteDomain: String? = nil,
    viewed: Bool = false,
    isHidden: Bool = false
  ) {
    self.rank = rank
    self.itemId = itemId
    self.hasAuthor = hasAuthor
    self.author = author
    self.createdAt = createdAt
    self.numComments = numComments
    self.score = score
    self.title = title
    self.url = url
    self.siteDomain = siteDomain
    self.viewed = viewed
    self.isHidden = isHidden
  }

  convenience init(fromDTO dto: PostDTO) {
    var author: Author?
    if dto.hasAuthor, let dtoAuthor = dto.author {
      author = Author(fromDTO: dtoAuthor)
    }

    self.init(
      rank: dto.rank,
      itemId: dto.itemId,
      author: author,
      createdAt: dto.createdAt,
      numComments: dto.numComments,
      score: dto.score,
      title: dto.title,
      url: dto.url,
      siteDomain: dto.siteDomain,
      isHidden: dto.isHidden
    )
  }
}

extension Array where Element: Post {
  subscript(id: Post.ID?) -> Post? {
    first { $0.id == id }
  }
}

extension Post: Identifiable {}

// MARK: - Data Transfer Object

final class PostDTO: PostProvider & DTO {
  let rank: Int
  let itemId: HNID
  let hasAuthor: Bool
  let author: AuthorDTO?
  let createdAt: Date
  let numComments: Int
  let score: Int
  let title: String
  let url: URL?
  let siteDomain: String?
  let viewed: Bool
  let isHidden: Bool

  init(
    rank: Int,
    itemId: HNID,
    hasAuthor: Bool,
    author: AuthorDTO?,
    createdAt: Date,
    numComments: Int = 0,
    score: Int = 0,
    title: String,
    url: URL?,
    siteDomain: String?,
    viewed: Bool,
    isHidden: Bool
  ) {
    self.rank = rank
    self.itemId = itemId
    self.hasAuthor = hasAuthor
    self.author = author
    self.createdAt = createdAt
    self.numComments = numComments
    self.score = score
    self.title = title
    self.url = url
    self.siteDomain = siteDomain
    self.isHidden = isHidden
    self.viewed = viewed
  }
}
