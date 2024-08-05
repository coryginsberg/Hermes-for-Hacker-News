//
// Copyright (c) 2023 - Present Cory Ginsberg
// Licensed under Apache License 2.0
//

import Alamofire
import Foundation
import SwiftData
import SwiftUI

struct PostListPageFetcher {
  let baseUrl = URL(string: "https://news.ycombinator.com")
  var isFetching = false

  func fetch() async throws -> String {
    if let baseUrl {
      let result = await AF.request(baseUrl, interceptor: .retryPolicy)
        .cacheResponse(using: .cache)
        .redirect(using: .doNotFollow)
        .validate()
        .serializingResponse(using: .string)
        .result
      return try result.get()
    }
    throw URLError(.unsupportedURL)
  }
}

class PostListPage {
  var page: String = ""
}

extension PostListPage {
  func fetch() async {
    do {
      self.page = try await PostListPageFetcher().fetch()
    } catch {
      print(error)
    }
  }
}
