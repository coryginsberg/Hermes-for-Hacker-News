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
    let postListRef: DatabaseReference
    switch storiesTypes {
    case .topStories:
      postListRef = ref.child("v0/topstories")
    case .newStories:
      postListRef = ref.child("v0/newstories")
    case .bestStories:
      postListRef = ref.child("v0/beststories")
    }
    await fetchPosts(from: postListRef)
  }

  @MainActor
  private func fetchPosts(from ref: DatabaseReference) async {
    do {
      let snapshot = try await ref.queryLimited(toFirst: 50).getData()
      guard let snapshotVal = snapshot.value as? [Int] else { return }
      posts = try await snapshotVal.concurrentCompactMap { value throws in
        await PostInfo(value)
      }
    } catch {
      print(error.localizedDescription)
      return
    }
  }

  func fetchPostsInfo() async throws -> [ItemInfo] {
    await posts.asyncCompactMap {
      await PostInfo($0.delegate.itemData.id)
    }
  }

  func onViewDisappear() {
    ref.removeAllObservers()
  }
}
