//
// Copyright (c) 2024 Cory Ginsberg.
// Licensed under the Apache License, Version 2.0
//

import Foundation
import SwiftData
import SwiftSoup
import SwiftUI
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
    guard let posts = try? htmlDocument.getElementsByClass("athing").array()
    else {
      throw URLError(.badURL)
    }

    try modelContext.transaction {
      for post in posts {
        let rank = try post.getElementsByClass("rank").first()?.ownText()
          .integerValue ?? 0
        let titleLine = try post.getElementsByClass("titleline").first()
        let titleAnchor = try titleLine?.getElementsByTag("a").first()
        let siteDomain = try titleLine?.getElementsByClass("sitestr").first()?
          .ownText()
        let url = try titleAnchor?.attr("href") ?? ""
        let subline = try post.nextElementSibling()?
          .getElementsByClass("subline").first()
        let score = try subline?.getElementsByClass("score").first()?.ownText()
          .integerValue ?? 0
        let authorElem = try subline?.getElementsByClass("hnuser").first()
        let authorText = try authorElem?.text() ?? ""
        let authorColor = try authorElem?.getElementsByTag("font").first()?
          .attr("color") ?? nil
        let author = Author(
          username: authorText,
          color: authorColor
        )
        let timeStr = try (subline?.getElementsByClass("age").first()?
          .attr("title") ?? "") + "+0000"
        let time = ISO8601DateFormatter().date(from: timeStr) ?? Date()
        let numComments = try subline?.children().last()?.text()
          .integerValue ?? 0
        if let hnid = HNID(post.id()) {
          let post = Post(rank: rank,
                          itemId: hnid,
                          author: author,
                          createdAt: time,
                          numComments: numComments,
                          score: score,
                          title: titleAnchor?.ownText() ?? "",
                          url: URL(string: url),
                          siteDomain: siteDomain)
          if let postHistory = try modelContext.fetch(PostHistory.fetch(for: hnid)).first {
            post.postHistory = postHistory
          }
          modelContext.insert(post)
        } else {
          throw RuntimeError("Failed to parse post")
        }
      }
    }
  }
}
