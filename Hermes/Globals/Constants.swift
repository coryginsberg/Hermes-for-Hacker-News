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

  enum Sorts: String {
    case news // Homepage
    case newest
    case best
    case ask
    case show
    case jobs
    case front // `/front` is structured `/front?day=2024-08-05`. Defaults to yesterday.
  }
}
