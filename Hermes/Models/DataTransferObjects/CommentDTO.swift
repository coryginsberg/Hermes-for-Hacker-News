//
// Copyright (c) 2023 - Present Cory Ginsberg
// Licensed under Apache License 2.0
//

final class AuthorDTO: Sendable, Identifiable {
  let username: String
  // NOTE: Green (newb) users are only highlighed when logged in
  let color: String?

  init(username: String, color: String? = nil) {
    self.username = username
    self.color = color
  }
}
