//
// Copyright (c) 2023 - Present Cory Ginsberg
// Licensed under Apache License 2.0
//

import Foundation

extension Error {
  func errorCode() -> Int {
    let nsError = self as NSError
    return nsError.code
  }

  func errorDomain() -> String {
    let nsError = self as NSError
    return String(describing: nsError.domain)
  }
}

// MARK: - FetchResultsError enum

enum FetchResultsError: Error {
  /// Errors on the query request itself
  enum QueryError: Error {
    case noSearchCriteria
    case notInStoryList
  }

  /// Errors that occur when loading feature data
  enum DownloadError: Error {
    case wrongDataFormat(error: Error)
    case missingData
  }
}

enum StoryListError: Error, Equatable {
  case storyTypeRequired
  case noMorePosts
  case databaseRefUrlNotFound
  case objectIdNotFound
}

enum GenericError: Error {
  case missingValue(String)
  case missingUrl
}
