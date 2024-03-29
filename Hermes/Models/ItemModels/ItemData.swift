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
import UIKit

typealias HNID = UInt32

struct ItemData {
  enum TypeVal: String {
    case job
    case story
    case comment
    case poll
    case pollopt
  }

  var author: String = "" // The username of the item's author.
  var descendants: Int?
  var dead: Bool = false // true if the item is dead.
  var deleted: Bool = false // true if the item is deleted.
  var id: HNID = 0 // The item's unique id.
  var kids: [HNID]? = [] // The ids of the item's comments, in ranked display order.
  var parent: HNID? = 0 // The comment's parent: either another comment or the relevant story.
  var parts: [HNID]? = [] // A list of related pollopts, in display order.
  var poll: HNID? // The pollopt's associated poll.
  var score: Int = 0 // The story's score, or the votes for a pollopt.
  var text: String? // The comment, story or poll text. HTML.
  var time: Date = .init() // Creation date of the item, in Unix Time.
  var title: String? // The title of the story, poll or job. HTML.
  var type: TypeVal = .story // The type of item. One of "job", "story", "comment", "poll", or "pollopt".
  var url: URL? // The URL of the story.
  var faviconUrl: URL?

  // MARK: - Default

  init() {}
  init(author: String,
       descendants: Int?,
       dead: Bool,
       deleted: Bool,
       id: HNID,
       kids: [HNID]?,
       parent: HNID?,
       parts: [HNID]?,
       poll: HNID?,
       score: Int,
       text: String?,
       time: Date,
       title: String?,
       type: TypeVal,
       url: URL?,
       faviconURL: URL?)
  {
    self.author = author
    self.descendants = descendants
    self.dead = dead
    self.deleted = deleted
    self.id = id
    self.kids = kids
    self.parent = parent
    self.parts = parts
    self.poll = poll
    self.score = score
    self.text = text
    self.time = time
    self.title = title
    self.type = type
    self.url = url
    self.faviconUrl = faviconURL
  }

  // MARK: - Story Link

  init(forLink url: URL,
       author: String,
       dead: Bool,
       deleted: Bool,
       descendants: Int,
       id: HNID,
       score: Int,
       time: Date,
       title: String,
       faviconURL: URL?)
  {
    self.init(author: author,
              descendants: descendants,
              dead: dead,
              deleted: deleted,
              id: id,
              kids: [],
              parent: nil,
              parts: nil,
              poll: nil,
              score: score,
              text: nil,
              time: time,
              title: title,
              type: .story,
              url: url,
              faviconURL: faviconURL)
  }

  // MARK: - Story Text

  init(forStory title: String,
       author: String,
       dead: Bool,
       deleted: Bool,
       descendants: Int,
       id: HNID,
       score: Int,
       text: String,
       time: Date)
  {
    self.init(author: author,
              descendants: descendants,
              dead: dead,
              deleted: deleted,
              id: id,
              kids: [],
              parent: nil,
              parts: nil,
              poll: nil,
              score: score,
              text: text,
              time: time,
              title: title,
              type: .story,
              url: nil,
              faviconURL: nil)
  }

  // MARK: - Job

  init(forJob author: String,
       dead: Bool,
       deleted: Bool,
       id: HNID,
       score: Int,
       text: String?,
       time: Date,
       title: String,
       url: URL?)
  {
    self.init(author: author,
              descendants: nil,
              dead: dead,
              deleted: deleted,
              id: id,
              kids: nil,
              parent: nil,
              parts: nil,
              poll: nil,
              score: score,
              text: text,
              time: time,
              title: title,
              type: .job,
              url: url,
              faviconURL: nil)
  }

  // MARK: - Comment

  init(forComment author: String,
       descendants: Int?,
       dead: Bool,
       deleted: Bool,
       id: HNID,
       kids: [HNID]?,
       parent: HNID?,
       score: Int,
       text: String?,
       time: Date)
  {
    self.init(author: author,
              descendants: descendants,
              dead: dead,
              deleted: deleted,
              id: id,
              kids: kids,
              parent: parent,
              parts: nil,
              poll: nil,
              score: score,
              text: text,
              time: time,
              title: nil,
              type: .comment,
              url: nil,
              faviconURL: nil)
  }
}
