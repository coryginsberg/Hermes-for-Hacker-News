//
// Copyright (c) 2024 Cory Ginsberg.
// Licensed under the Apache License, Version 2.0
//

import FirebaseDatabase

class CommentListViewModel: ObservableObject {
  @Published var items: [ItemInfo] = []
  @Published var isLoadingPage = false

  private let ref = Database.root
  private var commentListRef: DatabaseReference?
  private var canLoadMoreItems = true

  init(withComments comments: [Int]) {
    Task {
      do {
        try await genLoadComments(comments)
      } catch {
        print("found error")
      }
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
    for comment in comments {
      Task {
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
