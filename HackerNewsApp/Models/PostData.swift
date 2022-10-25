//
//  Copyright (c) 2022 Cory Ginsberg.
//  Licensed under the Apache License, Version 2.0
//

import Foundation

// MARK: - Post
struct PostData {
  let author: String
  let descendants: Int?
  let id: Int
  let kids: [Int]?
  let score: Int
  let time: String
  let title: String
  let type: String
  let url: String?
}
