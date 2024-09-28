//
// Copyright (c) 2023 - Present Cory Ginsberg
// Licensed under Apache License 2.0
//

// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let gitHubUser = try? JSONDecoder().decode(GitHubUser.self, from: jsonData)

import Foundation

// MARK: - GitHubUser

struct GitHubUser: Codable, Sendable {
  let login: String
  let id: Int
  let avatarURL: String
  let gravatarID: String

  enum CodingKeys: String, CodingKey {
    case login
    case id
    case avatarURL = "avatar_url"
    case gravatarID = "gravatar_id"
  }
}
