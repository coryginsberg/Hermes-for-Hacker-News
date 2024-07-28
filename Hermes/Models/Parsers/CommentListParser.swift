//
// Copyright (c) 2023 - Present Cory Ginsberg
// Licensed under Apache License 2.0
//

import Foundation
import SwiftSoup

final class CommentListParser: HTMLParser, HTMLParserDelegate {
  typealias Element = Comment

  required init(_ document: String) throws {
    try super.init(document)
    delegate = self
  }
}

extension HTMLParserDelegate where Element == Comment {
  func getAllElements() throws -> [Comment] { return [] }
}
