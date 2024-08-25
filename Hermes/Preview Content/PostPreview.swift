////
//// Copyright (c) 2023 - Present Cory Ginsberg
//// Licensed under Apache License 2.0
////
//
// import Foundation
// import OSLog
// import SwiftData
//
// actor PreviewSampleData {
//  @MainActor static var container: ModelContainer = {
//    do {
//      return try inMemoryContainer()
//    } catch {
//      Slog.error(error, message: "Error creating in memory container:")
//      fatalError("Error creating in memory container: \(error)")
//    }
//  }()
//
//  @MainActor static var inMemoryContainer: () throws -> ModelContainer = {
//    let schema = Schema([Post.self])
//    let configuration = ModelConfiguration(isStoredInMemoryOnly: true)
//    let container = try ModelContainer(for: schema, configurations: [configuration])
//    let sampleData: [any PersistentModel] = [
//      Post.smallText,
//      Post.mediumText,
//      Post.longText,
//      Post.link,
//      Post.formattedText,
//    ]
//    for sampleData in sampleData {
//      container.mainContext.insert(sampleData)
//    }
//    return container
//  }
// }
//
//// Default posts to use in previews
// extension Post {
//  private static let titles = [
//    "Post with URL",
//    "Ask HN: Who is hiring? (formatted text)",
//  ]
//
//  private static let texts = [
//    "",
//    "Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Donec odio. Quisque volutpat mattis eros. Nullam " +
//      "malesuada erat ut turpis. Suspendisse urna nibh viverra non semper suscipit posuere a pede.",
//    nil,
//    """
//    Please state the location and include REMOTE, INTERNS and/or VISA
//    when that sort of candidate is welcome. When remote work is <i>not</i> an option,
//    include ONSITE.<p>Please only post if you personally are part of the hiring company—no
//    recruiting firms or job boards. One post per company. If it isn't a household name,
//    explain what your company does.</p><p>Commenters: please don't reply to job posts to complain about
//    something. It's off topic here.</p><p>Readers: please only email if you are personally interested in the job.</p>
//    <p>Searchers: try <a href="https://hnresumetojobs.com" rel="nofollow">https://hnresumetojobs.com</a>,
//    <a href="https://hnhired.fly.dev" rel="nofollow">https://hnhired.fly.dev</a>,
//    """,
//  ]
//
//  static var smallText: Post {
//    .init(postId: 40500071,
//          tags: [],
//          author: "realslimginz",
//          children: nil,
//          createdAt: Date(),
//          numComments: 15,
//          points: 19,
//          title: "Ask HN: Post with short text",
//          updatedAt: Date(),
//          url: nil,
//          text: "Lorem ipsum dolor sit amet",
//          index: 0)
//  }
//
//  static var mediumText: Post {
//    .init(postId: 40510071,
//          tags: [],
//          author: "realslimginz",
//          children: nil,
//          createdAt: Date(),
//          numComments: 15,
//          points: 19,
//          title: "Post with medium text",
//          updatedAt: Date(),
//          url: nil,
//          text: "Donec nec justo eget felis facilisis fermentum. Aliquam porttitor mauris sit amet orci. Aenean " +
//            "dignissim pellentesque felis.",
//          index: 0)
//  }
//
//  static var longText: Post {
//    .init(postId: 40501071,
//          tags: [],
//          author: "realslimginz",
//          children: nil,
//          createdAt: Date(),
//          numComments: 15,
//          points: 19,
//          title: "Show HN: Post with long text",
//          updatedAt: Date(),
//          url: nil,
//          text: "Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Donec odio. Quisque volutpat mattis eros. " +
//            "Nullam malesuada erat ut turpis. Suspendisse urna nibh viverra non semper suscipit posuere a pede.",
//          index: 0)
//  }
//
//  static var link: Post {
//    .init(postId: 40500171,
//          tags: [],
//          author: "realslimginz",
//          children: nil,
//          createdAt: Date(),
//          numComments: 15,
//          points: 19,
//          title: "Post with URL",
//          updatedAt: Date(),
//          url: "https://www.example.com/",
//          text: nil,
//          index: 0)
//  }
//
//  static var formattedText: Post {
//    .init(postId: 40500071,
//          tags: [],
//          author: "realslimginz",
//          children: nil,
//          createdAt: Date(),
//          numComments: 15,
//          points: 19,
//          title: "Ask HN: Who is hiring? (formatted text)",
//          updatedAt: Date(),
//          url: nil,
//          text: """
//          Please state the location and include REMOTE, INTERNS and/or VISA when that sort of candidate is welcome. When remote work is <i>not</i> an option, include ONSITE.<p>Please only post if you personally are part of the hiring company—no recruiting firms or job boards. One post per company. If it isn't a household name, explain what your company does.</p><p>Commenters: please don't reply to job posts to complain about something. It's off topic here.</p><p>Readers: please only email if you are personally interested in the job.</p><p>Searchers: try <a href="https: // hnresumetojobs.com" rel="nofollow">https://hnresumetojobs.com</a>, <a href="https://hnhired.fly.dev" rel="nofollow">https://hnhired.fly.dev</a>, <a href="https://kennytilton.github.io/whoishiring/" rel="nofollow">https://kennytilton.github.io/whoishiring/</a>, <a href="https://hnjobs.emilburzo.com" rel="nofollow">https://hnjobs.emilburzo.com</a>.</p><p>Don't miss these other fine threads:</p><p><i>Who wants to be hired?</i> <a href="https://news.ycombinator.com/item?id=40563280">https://news.ycombinator.com/item?id=40563280</a></p><p><i>Freelancer? Seeking freelancer?</i> <a href="https://news.ycombinator.com/item?id=40563281">https://news.ycombinator.com/item?id=40563281</a></p>
//          """,
//          index: 0)
//  }
// }
