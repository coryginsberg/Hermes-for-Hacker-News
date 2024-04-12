//
// Copyright (c) 2024 Cory Ginsberg.
// Licensed under the Apache License, Version 2.0
//

import Foundation

enum StoryListError: Error, Equatable {
  case storyTypeRequired
  case noMorePosts
  case databaseRefUrlNotFound
  case objectIdNotFound
}
