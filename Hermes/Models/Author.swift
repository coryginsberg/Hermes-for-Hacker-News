//
// Copyright (c) 2023 - Present Cory Ginsberg
// Licensed under Apache License 2.0
//

import SwiftData
import SwiftUICore
import UIKit

@Model
final class Author: AuthorProvider {
  #Unique<Author>([\.username])

  var username: String
  var isNewUser: Bool = false
  var customColor: String?
  @Relationship(deleteRule: .cascade, inverse: \Post.author) var posts = [Post]()

  required init(username: String, isNewUser: Bool = false, customColor: String? = nil) {
    self.username = username
    self.isNewUser = isNewUser
    self.customColor = customColor ?? checkCustomColor(username)
  }

  convenience init(fromDTO dto: AuthorDTO) {
    self.init(username: dto.username, isNewUser: dto.isNewUser, customColor: dto.customColor)
  }

  func checkCustomColor(_ username: String) -> String? {
    let customColorList = ["realslimginz": Color.purple.description, "dang": Color.blue.description]
    guard let customColor = customColorList.first(where: { $0.key == username }) else {
      return nil
    }
    return customColor.value
  }
}

extension Array where Element: Author {
  subscript(id: Author.ID?) -> Author? {
    first { $0.id == id }
  }
}

extension Author: Identifiable {}

// MARK: - Data Transfer Object

final class AuthorDTO: AuthorProvider & DTO {
  let username: String
  let isNewUser: Bool
  let customColor: String?

  init(username: String, isNewUser: Bool = false, customColor: String? = nil) {
    self.username = username
    self.isNewUser = isNewUser
    self.customColor = customColor
  }

  convenience init(from author: Author) {
    self.init(username: author.username, isNewUser: author.isNewUser, customColor: author.customColor)
  }
}
