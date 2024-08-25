//
// Copyright (c) 2023 - Present Cory Ginsberg
// Licensed under Apache License 2.0
//

import SwiftData
import UIKit

@Model
final class Author: AuthorProvider {
  var username: String
  var color: String?

  required init(username: String, color: String? = nil) {
    self.username = username
    self.color = color
  }

  convenience init(fromDTO dto: AuthorDTO) {
    self.init(username: dto.username, color: dto.color)
  }
}

extension Array where Element: Author {
  subscript(id: Author.ID?) -> Author? {
    first { $0.id == id }
  }
}

extension Author: Identifiable {}

// MARK: - Data Transfer Object

final class AuthorDTO: AuthorProvider, DTO {
  let username: String
  let color: String?

  init(username: String, color: String?) {
    self.username = username
    self.color = color
  }

  convenience init(from author: Author) {
    self.init(username: author.username, color: author.color)
  }
}
