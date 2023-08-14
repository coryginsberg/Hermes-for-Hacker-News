//
//  CommentsViewModel.swift
//  HackerNewsApp
//
//  Created by Cory Ginsberg on 7/29/23.
//

import FirebaseDatabase
import Foundation

class CommentListViewModel: ObservableObject {
  @Published var comments: [ItemInfo] = []

  private let ref = Database.root

  @MainActor
  func fetchComments(from ref: DatabaseReference) async {
    do {
      let snapshot = try await ref.queryLimited(toFirst: 50).getData()
      guard let snapshotVal = snapshot.value as? [Int] else { return }

      comments = try await snapshotVal.concurrentCompactMap { value throws in
        try await CommentInfo(for: value)
      }
    } catch {
      print(error.localizedDescription)
      return
    }
  }
}
