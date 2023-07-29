//
//  PostDataTest.swift
//  HackerNewsApp
//
//  Created by Cory Ginsberg on 7/27/23.
//

import Foundation

struct TestData {
  private static let titles = [
    "Ask HN: Who here hacks McDonalds trash?", "Ask HN: Am I crazy to steal Farmville strategies?",
    "Introducing BushBloat: a Ruby framework optimizer",
    "When a Shaolin monk met a programmer from the Silicon Valley",
    "The lost art of taking meeting notes",
    "a fully functional deathstar in 10 lines of clojure",
    "How I turned making vaporware into a $6 million a year business",
    "FTX owes $254.26 to Coinbase",
  ]

  private static let authors = ["TrustyVerdict", "pressure_wedge", "UraniumOxide", "deno77", "medagutmann51"]

  private static let types = ["job", "story", "poll"]

  static let postsData = titles.map { title in
    ItemData(
      author: authors.randomElement()!,
      descendants: nil,
      dead: false,
      deleted: false,
      id: Int.random(in: 100000..<1_000_000),
      kids: nil,
      parent: nil,
      parts: nil,
      poll: nil,
      score: Int.random(in: 1..<600),
      text:
        """
        Lorem ipsum dolor sit amet, consectetur adipiscing elit,
        sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.
        """,
      time: "\(Int.random(in: 1_670_495_658...1_690_495_658))",
      title: title,
      type: types[1],
      url: nil,
      faviconUrl: nil
    )
  }.shuffled()
}
