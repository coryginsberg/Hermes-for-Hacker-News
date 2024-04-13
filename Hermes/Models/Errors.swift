//
// Copyright (c) 2023 - Present Cory Ginsberg
// Licensed under Apache License 2.0
//

import Foundation

enum StoryListError: Error, Equatable {
  case storyTypeRequired
  case noMorePosts
  case databaseRefUrlNotFound
  case objectIdNotFound
}
