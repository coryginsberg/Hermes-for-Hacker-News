//
// Copyright (c) 2023 - Present Cory Ginsberg
// Licensed under Apache License 2.0
//

import Foundation
import SwiftSoup
import SwiftUICore

final class PostListParser: HTMLParser, HTMLParserDelegate {
  typealias Element = Post

  required init(_ document: String) throws {
    try super.init(document)
    delegate = self
  }
}

extension HTMLParserDelegate where Element == Post {
  func getAllElements() throws -> [Post] {
    guard let posts = try? htmlDocument.getElementsByClass("athing").array() else {
      throw URLError(.badURL)
    }
    return try posts.map { post in
      let titleAnchor = try post.getElementsByClass("titleline").first()?.getElementsByTag("a").first()
      let url = try titleAnchor?.attr("href") ?? ""
      let subline = try post.nextElementSibling()?.getElementsByClass("subline").first()
      let score = try subline?.getElementsByClass("score").first()?.ownText() ?? ""
      let authorElem = try subline?.getElementsByClass("hnuser").first()
      let authorText = try authorElem?.text() ?? ""
      let authorColorAttr = try authorElem?.getElementsByTag("font").first()?.attr("color") ?? nil
      let authorColor = if let authorColorAttr { Color(authorColorAttr) } else { nil as Color? }
      let author = Author(
        username: authorText,
        color: authorColor
      )
      let time = try subline?.getElementsByClass("age").first()?.attr("title") ?? ""
      let numComments = try subline?.children().last()?.text().firstNumber
      if let hnid = HNID(post.id()) {
        return Post(itemId: hnid,
                    author: author,
                    createdAt: time,
                    numComments: numComments,
                    score: Int(score) ?? 0,
                    title: titleAnchor?.ownText() ?? "",
                    url: URL(string: url))
      }
      throw RuntimeError("Failed to parse post")
    }
  }
}
