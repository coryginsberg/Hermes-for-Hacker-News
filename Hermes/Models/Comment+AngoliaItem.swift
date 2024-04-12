//
//  Comment+AngoliaItem.swift
//  Hermes
//
//  Created by Cory Ginsberg on 4/12/24.
//

import OSLog
import SwiftData

private let logger = Logger(category: "Comment+AngoliaItem")

extension Comment {
  convenience init(from comment: AngoliaItem, index: Int, depth: Int) {
    let children = comment.children.map { child in
      Comment(from: child, index: 0, depth: depth + 1)
    }

    self.init(itemId: comment.id,
              author: comment.author,
              children: children,
              createdAt: comment.createdAt,
              parentId: comment.parentId,
              points: comment.points,
              storyId: comment.storyId,
              text: comment.text,
              depth: depth)
  }
}

extension AngoliaItem {
  @MainActor
  static func refresh(modelContext: ModelContext) async {
    do {
      try modelContext.delete(model: Comment.self)

      logger.debug("Refresh complete.")
    } catch {
      logger.error("\(error.localizedDescription)")
    }
  }
}
