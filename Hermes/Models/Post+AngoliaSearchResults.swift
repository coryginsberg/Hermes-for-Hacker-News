//
// Copyright (c) 2023 - Present Cory Ginsberg
// Licensed under Apache License 2.0
//

import OSLog
import SwiftData

private let logger = Logger(category: "Post+HNSearchResults")

extension Post {
  convenience init(from hit: AngoliaSearchResults.Hit, index: Int) throws {
    guard let objectId = Int(hit.objectId) else { throw StoryListError.objectIdNotFound }
    self.init(postId: objectId,
              tags: hit.tags,
              author: hit.author,
              children: hit.children.compactMap { $0 },
              createdAt: hit.createdAt,
              numComments: hit.numComments,
              points: hit.points,
              title: hit.title,
              updatedAt: hit.updatedAt,
              url: hit.url,
              storyText: hit.storyText,
              jobText: hit.jobText,
              index: index)
  }
}

extension AngoliaSearchResults {
  /// Loads new posts and deletes outdated ones.
  @MainActor
  static func refresh(modelContext: ModelContext) async {
    do {
      try modelContext.delete(model: Post.self)

      // Fetch the latest set of data from the server.
      logger.debug("Refreshing the data store...")
      let (featureCollection, storyList) = try await fetchStoryList(list: .topstories)
      logger.debug("Loaded feature collection:\n\(featureCollection)")
      // Add the content to the data store.
      for hit in featureCollection.hits {
        guard let objectId = Int(hit.objectId),
              let storyIndex = storyList.firstIndex(of: objectId) else {
          throw FetchResultsError.QueryError.notInStoryList
        }
        let post = try Post(from: hit, index: storyIndex)
        modelContext.insert(post)
      }

      logger.debug("Refresh complete.")
    } catch {
      logger.error("\(error.localizedDescription)")
    }
  }
}
