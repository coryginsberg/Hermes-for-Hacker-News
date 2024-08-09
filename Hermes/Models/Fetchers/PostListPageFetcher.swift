//
// Copyright (c) 2023 - Present Cory Ginsberg
// Licensed under Apache License 2.0
//

import Alamofire
import Foundation
import SwiftData
import SwiftUI

struct PostListPageFetcher {
  func fetch(_ sort: HN.Sorts = .news, page pageNumber: Int = 1, forDate date: Date? = nil) async throws -> String {
    // TODO: Add `?day={date}` to URL when sort = .front
    let pageQueryItem = URLQueryItem(name: "p", value: String(pageNumber))
    let url = HN.baseURL
      .appending(path: sort.rawValue)
      .appending(queryItems: [pageQueryItem])
    let result = await AF.request(url, interceptor: .retryPolicy)
      .cacheResponse(using: .cache)
      .redirect(using: .doNotFollow)
      .validate()
      .serializingString()
      .result
    return try result.get()
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
