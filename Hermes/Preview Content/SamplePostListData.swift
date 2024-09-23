//
// Copyright (c) 2023 - Present Cory Ginsberg
// Licensed under Apache License 2.0
//

import SwiftData
import SwiftUI

extension Post {
  // swiftlint:disable:next attributes
  @MainActor static func makeSamplePosts(in container: ModelContainer) {
    let posts = [
      // Short Text
      Post(rank: 1,
           itemId: 40500071,
           author: Author(username: "randomuser1"),
           createdAt: .now,
           score: 16,
           title: "Ask HN: Post with short text"),

      // Medium Text
      Post(rank: 2,
           itemId: 40501071,
           author: Author(username: "dang"),
           createdAt: .now,
           score: 19,
           title: "Donec nec justo eget felis facilisis fermentum. Aliquam porttitor mauris sit amet orci. Aenean " +
             "dignissim pellentesque felis."),

      // Long Text
      Post(rank: 3,
           itemId: 40501071,
           author: Author(username: "notarussianbot"),
           createdAt: .now,
           score: 19,
           title: "Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Donec odio. Quisque volutpat mattis. " +
             "Nullam malesuada erat ut turpis. Suspendisse urna nibh viverra non semper suscipit posuere a pede."),

      // Links
      Post(rank: 4,
           itemId: 40501071,
           author: Author(username: "xX_NewUser_Xx",
                          isNewUser: true),
           createdAt: .now,
           score: 19,
           title: "Show HN: This cool site I found!",
           url: URL(string: "https://www.google.com/"),
           siteDomain: "www.google.com"),
      Post(rank: 5,
           itemId: 40501071,
           author: Author(username: "randomuser1"),
           createdAt: .now,
           score: 19,
           title: "Show HN: This cool site I found! Lorem ipsum dolor sit amet",
           url: URL(string: "https://www.example.com/"),
           siteDomain: "www.example.com"),
      Post(rank: 6,
           itemId: 40501071,
           author: Author(username: "realslimginz"),
           createdAt: .now,
           score: 19,
           title: "This is my personal site. There are many like it but this one is mine. I'm writing a long title to" +
             " test how it wraps. Pickles.",
           url: URL(string: "https://www.coryginsberg.com/"),
           siteDomain: "www.coryginsberg.com"),
      Post(rank: 7,
           itemId: 40501071,
           author: Author(username: "randomuser3"),
           createdAt: .now,
           score: 19,
           title: "An even longer title to make sure wrapping looks good for links which Hacker News has a lot of. " +
             "Lorem ipsum dolor sit amet consectetuer adipiscing elit. Donec odio. Quisque volutpat mattis.",
           url: URL(string: "https://www.example.com/"),
           siteDomain: "www.example.com"),
    ]

    for post in posts {
      container.mainContext.insert(post)
    }
  }
}

struct SamplePostListData: PreviewModifier {
  static func makeSharedContext() throws -> ModelContainer {
    let config = ModelConfiguration(isStoredInMemoryOnly: true)
    let container = try ModelContainer(for: Post.self, configurations: config)
    Post.makeSamplePosts(in: container)
    return container
  }

  func body(content: Content, context: ModelContainer) -> some View {
    content.modelContainer(context)
  }
}

extension PreviewTrait where T == Preview.ViewTraits {
  @MainActor static var samplePostData: Self = .modifier(SamplePostListData())
}
