//
//  Copyright (c) 2022 Cory Ginsberg.
//  Licensed under the Apache License, Version 2.0
//

import FirebaseDatabase

class PostListViewModel: ObservableObject {
  @Published var posts: [ItemInfo] = []

  private let ref = Database.root
  private var refHandle: DatabaseHandle?

  func genPosts(storiesTypes: StoriesTypes) async {
    switch storiesTypes {
    case .topStories:
      let postListRef = ref.child("v0/topstories")
      await fetchPosts(from: postListRef, for: storiesTypes)
    case .newStories:
      let postListRef = ref.child("v0/newstories")
      await fetchPosts(from: postListRef, for: storiesTypes)
    case .bestStories:
      let postListRef = ref.child("v0/beststories")
      await fetchPosts(from: postListRef, for: storiesTypes)
    }
  }

  @MainActor
  private func fetchPosts(from ref: DatabaseReference, for storiesTypes: StoriesTypes) async {
    do {
      let snapshot = try await ref.queryLimited(toFirst: 50).getData()
      guard let snapshotVal = snapshot.value as? [Int] else { return }
      debugPrint(snapshotVal)

      self.posts = try await snapshotVal.concurrentCompactMap { (value) throws in
        await ItemInfo(itemID: value)
      }
    } catch {
      print(error.localizedDescription)
      return
    }
  }

  func fetchPostsInfo() async -> [ItemInfo] {
    await posts.asyncCompactMap {
      await ItemInfo(itemID: $0.itemID)
    }
  }

  func onViewDisappear() {
    ref.removeAllObservers()
  }
}
