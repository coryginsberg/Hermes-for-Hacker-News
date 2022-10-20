//
//  Copyright (c) 2022 Cory Ginsberg.
//  Licensed under the Apache License, Version 2.0
//

import Foundation

// MARK: - Post

struct PostData {
  let by: String
  let descendants: Int?
  let id: Int
  let kids: [Int]?
  let score: Int
  let time: Int
  let title: String
  let type: String
  let url: String?
}
