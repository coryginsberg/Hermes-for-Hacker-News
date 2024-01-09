//
//  TestData.swift
//  HackerNewsApp
//
//  Created by Cory Ginsberg on 7/27/23.
//

import Foundation

enum TestData {
  private static let authors = [
    "TrustyVerdict",
    "pressure_wedge",
    "UraniumOxide",
    "deno77",
    "medagutmann51",
  ]

  enum Posts {
    private static let titles = [
      "Ask HN: Who here hacks McDonalds trash?",
      "Ask HN: Am I crazy to steal Farmville strategies?",
      "Introducing BushBloat: a Ruby framework optimizer",
      "When a Shaolin monk met a programmer from the Silicon Valley",
      "The lost art of taking meeting notes",
      "a fully functional deathstar in 10 lines of clojure",
      "How I turned making vaporware into a $6 million a year business",
      "FTX owes $254.26 to Coinbase",
    ]

    private static let types = ["job", "story", "poll"]

    static let randomPosts = titles.map { title in
      ItemData(
        author: authors.randomElement()!,
        descendants: Int.random(in: 0 ..< 300),
        dead: Bool.random(),
        deleted: Bool.random(),
        id: UInt32.random(in: 100_000 ..< 1_000_000),
        kids: nil,
        parent: nil,
        parts: nil,
        poll: nil,
        score: Int.random(in: 1 ..< 600),
        text:
        """
        Lorem ipsum dolor sit amet, consectetur adipiscing elit,
        sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.
        """,
        time: Date(timeIntervalSince1970: TimeInterval(Int
            .random(in: 1_670_495_658 ... 1_690_495_658))),
        title: title,
        type: .story,
        url: URL(string: "www.google.com/search?q=hermes+god"),
        faviconURL: URL(string: "https://www.google.com/favicon.ico")
      )
    }.shuffled()
  }

  enum Comments {
    private static let comments = [
      """
      I disagree with the author. I know he's incredibly successful and right about pretty much everything he's ever
      said, but I've had some experience in this area and just finished reading through some of the archives and I
      think his focus is wrong. I'm going to ignore the technical issue and talk about the bigger picture and higher
      level things than what was said in the blog post. If the OP thinks that the process is most important, it's
      really about end results. But if he thinks it should be about the end results then he's an idiot for not thinking
      about the process. I'll weasel in a reference the startup I co-founded even though it's not directly relevant.
      """,
      """
      Here's a long detailed, objective explanation of everything related to this issue. It's probably more useful than
      the actual link and it may serve as one of the best efforts to consolidate information on this subject on the
      entire Internet. If it contains original research only a couple of readers will be qualified to tell. Half the
      people who pvote this won't understand more than the first two paragraphs.

      Edit: I anticipated the potential questions and added more information. Add some graphs and this could be a
      master's thesis.
      """,
      """
       As a Ruby guy, does this really matter for 95% of the world?
      """,
      """
       Fantastic article. Here's a little bit more about what was discussed. And some real life applications.
      """,
      """
       I know this is off-topic, but does anyone know how he got visual effect X on his blog? It looks very nice.
      """,
      """
      > giant snippet

      Here's a hyper-anal correction that is itself correct, but doesn't exactly contradict the OP.
      """,
    ]

    static let randomComments = comments.map { comment in
      ItemData(
        author: authors.randomElement()!,
        descendants: nil,
        dead: false,
        deleted: false,
        id: UInt32.random(in: 100_000 ..< 1_000_000),
        kids: nil,
        parent: nil,
        parts: nil,
        poll: nil,
        score: Int.random(in: 1 ..< 100),
        text: comment,
        time: Date(timeIntervalSince1970: TimeInterval(Int
            .random(in: 1_670_495_658 ... 1_690_495_658))),
        title: "",
        type: .comment,
        url: nil,
        faviconURL: nil
      )
    }.shuffled()
  }
}
