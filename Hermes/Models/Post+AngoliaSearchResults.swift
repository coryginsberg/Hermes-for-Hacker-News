//
// Copyright (c) 2023 - Present Cory Ginsberg
// Licensed under Apache License 2.0
//

import SwiftData

extension AngoliaSearchResults {
  /// Loads new posts and deletes outdated ones.
  @MainActor
  static func refresh(modelContext: ModelContext) async {
    do {
      try modelContext.delete(model: Post.self)

      // Fetch the latest set of data from the server.
      Slog.log(.info, message: "Refreshing the data store...")
      let (featureCollection, storyList) = try await fetchStoryList(list: .topstories)
      Slog.log(.info, message: "Loaded feature collection:\n\(featureCollection)")
      // Add the content to the data store.
      for hit in featureCollection.hits {
        guard let objectId = Int(hit.objectId),
              let storyIndex = storyList.firstIndex(of: objectId) else {
          throw FetchResultsError.QueryError.notInStoryList
        }
        let post = try Post(from: hit, index: storyIndex)
        modelContext.insert(post)
      }
      Slog.log(.debug, message: "Refresh complete.")
    } catch {
      Slog.error(error)
    }
  }
}
