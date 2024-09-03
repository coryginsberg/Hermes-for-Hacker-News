//
// Copyright (c) 2023 - Present Cory Ginsberg
// Licensed under Apache License 2.0
//

import SwiftData
import SwiftUI

struct SamplePostListData: PreviewModifier {
  static func makeSharedContext() throws -> ModelContainer {
    let config = ModelConfiguration(isStoredInMemoryOnly: true)
    let container = try ModelContainer(for: Post.self, configurations: config)
    try Post.makeSamplePosts(in: container)
    return container
  }

  func body(content: Content, context: ModelContainer) -> some View {
    content.modelContainer(context)
  }
}

extension PreviewTrait where T == Preview.ViewTraits {
  @MainActor static var samplePostData: Self = .modifier(SamplePostListData())
}

extension Post {
  @MainActor
  static func makeSamplePosts(in container: ModelContainer) throws {
    let posts = [
      // MARK: Short Text

      Post(rank: 1,
           itemId: 40500071,
           author: Author(username: "realslimginz",
                          color: nil),
           createdAt: .now,
           score: 16,
           title: "Ask HN: Post with short text"),

      // MARK: Medium Text

      Post(rank: 2,
           itemId: 40501071,
           author: Author(username: "realslimginz",
                          color: nil),
           createdAt: .now,
           score: 19,
           title: "Donec nec justo eget felis facilisis fermentum. Aliquam porttitor mauris sit amet orci. Aenean " +
             "dignissim pellentesque felis."),

      // MARK: Long Text

      Post(rank: 3,
           itemId: 40501071,
           author: Author(username: "realslimginz",
                          color: nil),
           createdAt: .now,
           score: 19,
           title: "Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Donec odio. Quisque volutpat mattis. " +
             "Nullam malesuada erat ut turpis. Suspendisse urna nibh viverra non semper suscipit posuere a pede."),

      // MARK: Link

      Post(rank: 4,
           itemId: 40501071,
           author: Author(username: "realslimginz",
                          color: nil),
           createdAt: .now,
           score: 19,
           title: "Show HN: This cool site I found!",
           url: URL(string: "https://www.example.com/"),
           siteDomain: "www.example.com"),
    ]

    try container.mainContext.transaction {
      for post in posts {
        container.mainContext.insert(post)
      }
    }
  }
}
