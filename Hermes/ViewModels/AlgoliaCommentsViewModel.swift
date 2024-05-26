//
// Copyright (c) 2023 - Present Cory Ginsberg
// Licensed under Apache License 2.0
//

import Foundation

final class AlgoliaCommentsViewModel: LoadableItemState<[Comment]>, LoadableItem {
  typealias TLoadFrom = Post

  @Published var numComments = 0

  func load(from post: Post) async {
    state = .loading
    do {
      let algoliaItem = try await AlgoliaItem.fetchItem(by: post.itemId)
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
        numComments = algoliaItem.children.reduce(0) { $0 + $1.children.count }
      }
    } catch {
      state = .failed(error)
    }
  }
}
