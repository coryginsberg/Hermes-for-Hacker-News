//
// Copyright (c) 2023 - Present Cory Ginsberg
// Licensed under Apache License 2.0
//

import Foundation

typealias HNID = Int

let numBeforeLoadMore = 7

// MARK: - Hacker News parser consts

enum HN {
  static let baseURL: URL = .init(staticString: "https://news.ycombinator.com/")

  enum Posts {
    static let maxNumPages: Int = 24
    static let numPostsPerPage: Int = 30
  }
}

enum UserDefaultKeys: String {
  case viewedPosts
}

// Allows arrays to be used in @AppStorage properties
extension Array: @retroactive RawRepresentable where Element: Codable {
  public init?(rawValue: String) {
    guard let data = rawValue.data(using: .utf8),
          let result = try? JSONDecoder().decode([Element].self, from: data)
    else {
      return nil
    }
    self = result
  }

  public var rawValue: String {
    guard let data = try? JSONEncoder().encode(self) else {
      return "[]"
    }
    let result = String(decoding: data, as: UTF8.self)
    return result
  }
}
