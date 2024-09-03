//
// Copyright (c) 2023 - Present Cory Ginsberg
// Licensed under Apache License 2.0
//

import SwiftData
import SwiftUI

struct SamplePostListData: PreviewModifier {
  static func makeSharedContext() throws -> ModelContainer {
    let container = try ModelContainer(for: Post.self)
    for post in Post.previewPosts() {
      container.mainContext.insert(post)
    }
    return container
  }

  func body(content: Content, context: ModelContainer) -> some View {
    content.modelContainer(context)
  }
}

extension Post {
  static func previewPosts() -> [Post] {
    return [
      // MARK: Short Text

      .init(rank: 1,
            itemId: 40500071,
            author: Author(username: "realslimginz",
                           color: nil),
            createdAt: .now,
            score: 16,
            title: "Ask HN: Post with short text"),

      // MARK: Medium Text

      .init(rank: 2,
            itemId: 40501071,
            author: Author(username: "realslimginz",
                           color: nil),
            createdAt: .now,
            score: 19,
            title: "Donec nec justo eget felis facilisis fermentum. Aliquam porttitor mauris sit amet orci. Aenean " +
              "dignissim pellentesque felis."),

      // MARK: Long Text

      .init(rank: 3,
            itemId: 40501071,
            author: Author(username: "realslimginz",
                           color: nil),
            createdAt: .now,
            score: 19,
            title: "Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Donec odio. Quisque volutpat mattis. " +
              "Nullam malesuada erat ut turpis. Suspendisse urna nibh viverra non semper suscipit posuere a pede."),

      // MARK: Link

      .init(rank: 3,
            itemId: 40501071,
            author: Author(username: "realslimginz",
                           color: nil),
            createdAt: .now,
            score: 19,
            title: "Show HN: This cool site I found!",
            url: URL(string: "https://www.example.com/"),
            siteDomain: "www.example.com"),
    ]
  }
}
