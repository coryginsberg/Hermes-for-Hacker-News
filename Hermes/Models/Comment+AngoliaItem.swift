////
//// Copyright (c) 2023 - Present Cory Ginsberg
//// Licensed under Apache License 2.0
////
//
// import OSLog
// import SwiftData
//
// private let logger = Logger(category: "Comment+AngoliaItem")
//
// extension AlgoliaItem {
//  @MainActor
//  static func loadItem(fromId id: HNID, modelContext: ModelContext) async {
//    do {
//      let angoliaItem = try await fetchItem(by: id)
//      switch angoliaItem.type {
//      case .comment:
//        try await modelContext.insert(Comment(from: angoliaItem))
//      case .story:
//        try await modelContext.insert(PostWithComments(from: angoliaItem.storyId))
//      }
//      logger.debug("Refresh complete.")
//    } catch {
//      logger.error("\(error.localizedDescription)")
//    }
//  }
// }
