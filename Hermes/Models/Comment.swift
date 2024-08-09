//
// Copyright (c) 2023 - Present Cory Ginsberg
// Licensed under Apache License 2.0
//

import SwiftData

@Model
final class Comment {
  var itemId: HNID
  var author: Author

  init(itemId: HNID, author: Author) {
    self.itemId = itemId
    self.author = author
  }
}
