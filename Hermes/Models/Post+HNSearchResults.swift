//
//  Post+HNSearchResults.swift
//  Hermes for Hacker News 2
//
//  Created by Cory Ginsberg on 3/31/24.
//

import OSLog
import SwiftData

private let logger = Logger(category: "Post+HNSearchResults")

extension Post {
  convenience init(from hit: HNSearchResults.Hit, index: Int) {
    self.init(postId: hit.storyId,
              tags: hit.tags,
              author: hit.author,
              children: hit.children?.compactMap { $0 } ?? [],
              createdAt: hit.createdAt,
              numComments: hit.numComments,
              points: hit.points,
              title: hit.title ?? "",
              updatedAt: hit.updatedAt,
              url: hit.url,
              storyText: hit.storyText,
              jobText: hit.jobText,
              index: index)
  }
}

extension HNSearchResults {
  /// A logger for debugging.

  /// Loads new posts and deletes outdated ones.
  @MainActor
  static func refresh(modelContext: ModelContext) async {
    do {
      try modelContext.delete(model: Post.self)

      // Fetch the latest set of quakes from the server.
      logger.debug("Refreshing the data store...")
      let (featureCollection, storyList) = try await fetchStoryList(list: .topstories)
      logger.debug("Loaded feature collection:\n\(featureCollection)")
      // Add the content to the data store.
      for hit in featureCollection.hits {
        guard let storyIndex = storyList.firstIndex(of: hit.storyId) else {
          throw FetchResultsError.QueryError.notInStoryList
        }
        let post = Post(from: hit, index: storyIndex)
        modelContext.insert(post)
      }

      logger.debug("Refresh complete.")
    } catch {
      logger.error("\(error.localizedDescription)")
    }
  }
}
