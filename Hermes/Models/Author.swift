//
// Copyright (c) 2023 - Present Cory Ginsberg
// Licensed under Apache License 2.0
//
import SwiftData
import SwiftUICore

@Model
final class Author {
  var id: HNID
  var username: String
  var color: Color? // NOTE: Green (newb) users are only highlighed for logged in

  init(username: String, color: Color? = nil) {
    self.username = username
    self.color = color
  }
}
