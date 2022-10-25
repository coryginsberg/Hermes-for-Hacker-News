//
//  Copyright (c) 2022 Cory Ginsberg.
//  Licensed under the Apache License, Version 2.0
//
// Stories, comments, jobs, Ask HNs and even polls are just items.
// They're identified by their ids, which are unique integers,
// and live under /v0/item/<id>
//
// See https://github.com/HackerNews/API#items for more info
//

import Foundation

// MARK: - Post
struct ItemData {
  let author: String // The username of the item's author.
  let descendants: Int?
  let dead: Bool // true if the item is dead.
  let deleted: Bool // true if the item is deleted.
  let id: Int // The item's unique id.
  let kids: [Int]? // The ids of the item's comments, in ranked display order.
  let parent: Int? // The comment's parent: either another comment or the relevant story.
  let parts: [Int]? // A list of related pollopts, in display order.
  let poll: Int? // The pollopt's associated poll.
  let score: Int // The story's score, or the votes for a pollopt.
  let text: String // The comment, story or poll text. HTML.
  let time: String // Creation date of the item, in Unix Time.
  let title: String // The title of the story, poll or job. HTML.
  let type: String // The type of item. One of "job", "story", "comment", "poll", or "pollopt".
  let url: String? // The URL of the story.
}
