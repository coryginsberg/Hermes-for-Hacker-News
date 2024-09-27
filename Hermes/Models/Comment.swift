//
// Copyright (c) 2023 - Present Cory Ginsberg
// Licensed under Apache License 2.0
//

import SwiftData

@Model
final class Comment: CommentProvider {
  var itemId: HNID
  @Relationship(deleteRule: .nullify) var author: Author

  init(itemId: HNID, author: Author) {
    self.itemId = itemId
    self.author = author
  }
}

extension Array where Element: Comment {
  subscript(id: Comment.ID?) -> Comment? {
    first { $0.id == id }
  }
}

extension Comment: Identifiable {}

// MARK: - Data Transfer Object

final class CommentDTO: CommentProvider & DTO {
  let itemId: HNID
  let author: AuthorDTO

  init(itemId: HNID, author: AuthorDTO) {
    self.itemId = itemId
    self.author = author
  }
}
