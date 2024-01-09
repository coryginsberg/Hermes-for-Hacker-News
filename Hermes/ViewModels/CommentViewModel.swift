//
//  Copyright (c) 2022 Cory Ginsberg.
//  Licensed under the Apache License, Version 2.0
//

import Foundation

import FirebaseDatabase

class CommentListViewModel: ObservableObject {
  @Published var items: [ItemInfo] = []
  @Published var isLoadingPage = false

  private let ref = Database.root
  private var commentListRef: DatabaseReference?
  private var canLoadMoreItems = true

  init(_ comments: [UInt32]) {
    Task {
      try await genLoadComments(comments)
    }
  }

  func refreshCommentList(forParentComments commentList: [HNID]) async throws {
    canLoadMoreItems = true
    try await genLoadComments(commentList)
  }

  @MainActor
  private func genLoadComments(_ comments: [HNID]) async throws {
    guard canLoadMoreItems else { return }
    guard !isLoadingPage else { return }
    isLoadingPage = true
    Task {
      for comment in comments {
        guard let commentInfo = try await CommentInfo(for: comment) else {
          throw NSError(domain: "Comment Info Domain", code: 42)
        }
        items.append(commentInfo)
      }
      isLoadingPage = false
    }
  }

  func onViewDisappear() {
    ref.removeAllObservers()
  }
}
