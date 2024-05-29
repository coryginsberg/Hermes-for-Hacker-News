//
// Copyright (c) 2023 - Present Cory Ginsberg
// Licensed under Apache License 2.0
//

import Foundation

final class AlgoliaCommentsViewModel: LoadableItemState<[Comment]>, LoadableItem {
  typealias TLoadFrom = Post

  @Published var numComments = 0

  func load(from post: Post, isPreview: Bool = false) async {
    state = .loading
    do {
      let algoliaItem = isPreview ?
        try AlgoliaItem.fetchItem(fromFile: "PostWithComments") :
        try await AlgoliaItem.fetchItem(by: post.itemId)
      DispatchQueue.main.async { [self] in
        if algoliaItem.children.isEmpty {
          state = .empty
          return
        }
        var comments: [Comment] = []
        for item in algoliaItem.children {
          do {
            try comments.append(Comment(from: item, forPost: post))
          } catch {
            state = .failed(error)
            return
          }
        }
        state = .loaded(comments)
        self.numComments = algoliaItem.children.reduce(0) { $0 + $1.children.count }
      }
    } catch {
      state = .failed(error)
    }
  }
}

// MARK: - AlgoliaItem extension for preview views

extension AlgoliaItem {
  static func fetchItem(fromFile filename: String) throws -> AlgoliaItem {
    guard let url = Bundle.main.url(forResource: filename,
                                    withExtension: "json") else {
      throw URLError(.badURL)
    }
    let data = try Data(contentsOf: url)
    let jsonDecoder = JSONDecoder()
    jsonDecoder.dateDecodingStrategy = self.jsonDecoderWithFractionalSeconds()
    return try jsonDecoder.decode(AlgoliaItem.self, from: data)
  }
}
