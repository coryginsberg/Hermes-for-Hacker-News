//
// Copyright (c) 2024 Cory Ginsberg.
// Licensed under the Apache License, Version 2.0
//

import Foundation

public typealias HNID = Int

// MARK: - Default Data

class ItemData {
  /// The username of the item's author.
  var author: String
  var descendants: Int?
  /// true if the item is dead.
  var dead: Bool
  /// true if the item is deleted.
  var deleted: Bool
  /// The item's unique id.
  var id: HNID
  /// The ids of the item's comments, in ranked display order.
  var kids: [HNID]?
  /// The comment's parent: either another comment or the relevant story.
  var parent: HNID?
  /// A list of related pollopts, in display order.
  var parts: [HNID]?
  /// The pollopt's associated poll.
  var poll: HNID?
  /// The story's score, or the votes for a pollopt.
  var score: Int
  /// The comment, story or poll text. HTML.
  var text: String?
  /// Creation date of the item, in Unix Time.
  var time: Date
  /// The title of the story, poll or job. HTML.
  var title: String?
  /// The type of item. One of "job", "story", "comment", "poll", or "pollopt".
  var type: ItemType
  /// The URL of the story.
  var url: URL?

  enum ItemType: String {
    case job
    case story
    case comment
    case poll
    case pollopt
    case unknown
  }

  convenience init() {
    self.init(author: "",
              descendants: nil,
              dead: false,
              deleted: false,
              id: 0,
              kids: [],
              parent: nil,
              parts: [],
              poll: nil,
              score: 0,
              text: nil,
              time: .init(),
              title: nil,
              type: .unknown,
              url: nil)
  }

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
       type: ItemType,
       url: URL?) {
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
  }
}

// MARK: - Post Data

class PostData: ItemData {
  init(author: String,
       dead: Bool,
       deleted: Bool,
       descendants: Int,
       id: HNID,
       kids: [HNID],
       score: Int,
       text: String? = nil,
       time: Date,
       title: String,
       url: URL? = nil,
       type: ItemType = .story) {
    super.init(author: author,
               descendants: descendants,
               dead: dead,
               deleted: deleted,
               id: id,
               kids: kids,
               parent: nil,
               parts: nil,
               poll: nil,
               score: score,
               text: text,
               time: time,
               title: title,
               type: type,
               url: url)
  }
}

// MARK: - Job Data

class JobData: PostData {
  init(author: String,
       dead: Bool,
       deleted: Bool,
       id: HNID,
       score: Int,
       text: String?,
       time: Date,
       title: String) {
    super.init(author: author,
               dead: dead,
               deleted: deleted,
               descendants: 0,
               id: id,
               kids: [],
               score: score,
               text: text,
               time: time,
               title: title,
               url: nil,
               type: .job)
  }
}

// MARK: - Comment Data

class CommentData: ItemData {
  init(
    author: String,
    descendants: Int?,
    dead: Bool,
    deleted: Bool,
    id: HNID,
    kids: [HNID]?,
    parent: HNID?,
    score: Int,
    text: String?,
    time: Date
  ) {
    let markdownText = text?.stringByDecodingHTMLEntities.htmlToMarkDown()
    super.init(
      author: author,
      descendants: descendants,
      dead: dead,
      deleted: deleted,
      id: id,
      kids: kids,
      parent: parent,
      parts: nil,
      poll: nil,
      score: score,
      text: markdownText,
      time: time,
      title: nil,
      type: .comment,
      url: nil
    )
  }
}
