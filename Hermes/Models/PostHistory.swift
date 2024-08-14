//
// Copyright (c) 2024 Cory Ginsberg.
// Licensed under the Apache License, Version 2.0
//

import Foundation
import SwiftData
import SwiftUI

@Model
class PostHistory {
  @Relationship(deleteRule: .cascade) var post: Post?
  @Attribute(.unique) var itemId: HNID
  var wasViewed: Bool
  var firstLoaded: Date = Date.now

  init(post: Post) {
    self.post = post
    itemId = post.itemId
    wasViewed = true
  }
}

// Ensure that the model's conformance to Identifiable is public.
extension PostHistory: Identifiable {}

extension PostHistory {
  public static func fetch(for itemId: HNID) -> FetchDescriptor<PostHistory> {
    var descriptor = FetchDescriptor<PostHistory>(
      predicate: #Predicate { $0.itemId == itemId }
    )
    descriptor.fetchLimit = 1
    descriptor.includePendingChanges = true
    return descriptor
  }
}
