//
// Copyright (c) 2023 - Present Cory Ginsberg
// Licensed under Apache License 2.0
//

import Foundation
import SwiftData
import SwiftSoup
import SwiftUICore
import UIKit

final class PostListParser: HTMLParser, HTMLParserDelegate {
  typealias Element = Post

  required init(_ document: String) throws {
    try super.init(document)
    delegate = self
  }
}

extension HTMLParserDelegate where Element == Post {
  func queryAllElements(for modelContext: ModelContext) throws {
    guard let posts = try? htmlDocument.getElementsByClass("athing").array() else {
      throw URLError(.badURL)
    }

    try modelContext.transaction {
      for post in posts {
        let titleAnchor = try post.getElementsByClass("titleline").first()?.getElementsByTag("a").first()
        let url = try titleAnchor?.attr("href") ?? ""
        let subline = try post.nextElementSibling()?.getElementsByClass("subline").first()
        let score = try subline?.getElementsByClass("score").first()?.ownText().integerValue ?? 0
        let authorElem = try subline?.getElementsByClass("hnuser").first()
        let authorText = try authorElem?.text() ?? ""
        let authorColorAttr = try authorElem?.getElementsByTag("font").first()?.attr("color") ?? nil
        let authorColor = if let authorColorAttr { UIColor(hexColor: authorColorAttr) } else { nil as UIColor? }
        let author = Author(
          username: authorText,
          color: authorColor
        )
        let timeStr = try (subline?.getElementsByClass("age").first()?.attr("title") ?? "") + "+0000"
        let time = ISO8601DateFormatter().date(from: timeStr) ?? Date()
        print(timeStr)
        let numComments = try subline?.children().last()?.text().integerValue ?? 0
        if let hnid = HNID(post.id()) {
          modelContext.insert(Post(itemId: hnid,
                                   author: author,
                                   createdAt: time,
                                   numComments: numComments,
                                   score: score,
                                   title: titleAnchor?.ownText() ?? "",
                                   url: URL(string: url)))
        } else {
          throw RuntimeError("Failed to parse post")
        }
      }
    }
  }
}
