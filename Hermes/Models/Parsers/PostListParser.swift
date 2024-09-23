//
// Copyright (c) 2023 - Present Cory Ginsberg
// Licensed under Apache License 2.0
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
  func queryAllElements(for container: ModelContainer) async throws {
    guard let posts = try? htmlDocument.getElementsByClass("athing").array()
    else {
      throw URLError(.badURL)
    }

    let modelActor = PostModelActor(modelContainer: container)
    let postsDTO = try posts.map { post in
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
      var author: AuthorDTO?
      if let authorElem {
        author = try self.queryAuthor(fromElem: authorElem)
      } else {
        author = nil as AuthorDTO?
      }
      let timeStr = try (subline?.getElementsByClass("age").first()?
        .attr("title") ?? "") + "+0000"
      let time = ISO8601DateFormatter().date(from: timeStr) ?? Date()
      let numComments = try subline?.children().last()?.text()
        .integerValue ?? 0
      guard let hnid = HNID(post.id()) else {
        throw RuntimeError("Failed to parse post")
      }
      return PostDTO(rank: rank,
                     itemId: hnid,
                     hasAuthor: author != nil,
                     author: author,
                     createdAt: time,
                     numComments: numComments,
                     score: score,
                     title: titleAnchor?.ownText() ?? "",
                     url: URL(string: url),
                     siteDomain: siteDomain,
                     viewed: Self.wasPostViewed(forHNID: hnid),
                     isHidden: false) // TODO: Check `isHidden` same way as `viewed`
    }
    try await modelActor.insert(postsDTO)
  }

  func queryAuthor(fromElem authorElem: SwiftSoup.Element) throws -> AuthorDTO {
    let authorText = try authorElem.text()
    let authorHasColor = try authorElem.getElementsByTag("font").hasAttr("color")
    return AuthorDTO(
      username: authorText,
      isNewUser: authorHasColor
    )
  }

  static func wasPostViewed(forHNID postId: HNID) -> Bool {
    let viewedPosts = UserDefaults.standard.array(forKey: UserDefaultKeys.viewedPosts.rawValue)
    if let viewedPosts = viewedPosts as? [HNID] {
      return viewedPosts.containsItem(postId)
    } else {
      UserDefaults.standard.set([HNID](), forKey: UserDefaultKeys.viewedPosts.rawValue)
      return false
    }
  }
}
