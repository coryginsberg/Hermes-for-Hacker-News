//
// Copyright (c) 2023 - Present Cory Ginsberg
// Licensed under Apache License 2.0
//

import SwiftData
import UIKit

@Model
final class Author {
  var username: String
  // NOTE: Green (newb) users are only highlighed when logged in
  var color: String?

  init(username: String, color: String? = nil) {
    self.username = username
    self.color = color
  }
}
