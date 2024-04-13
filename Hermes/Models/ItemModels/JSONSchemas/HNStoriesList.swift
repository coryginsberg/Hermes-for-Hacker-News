//
// Copyright (c) 2023 - Present Cory Ginsberg
// Licensed under Apache License 2.0
//

import Foundation

// Technically this is the JSON schema for the stories list xD
typealias HNStoriesList = [HNID]

// MARK: - Fetch Stories List

extension HNStoriesList {
  enum StoryLists: String {
    case topstories // also contains jobs
    case newstories
    case beststories

    case askstories // Ask HN
    case showstories // Show HN
    case jobstories
  }

  static func fetch(withStoryList storyList: StoryLists) async throws -> HNStoriesList {
    let hnUrl = URL(string: "https://hacker-news.firebaseio.com/v0/\(storyList).json")
    return try await ItemFetcher.fetch(fromUrl: hnUrl)
  }
}
