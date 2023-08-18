//
//  Copyright (c) 2022 Cory Ginsberg.
//  Licensed under the Apache License, Version 2.0
//

import FirebaseDatabase

class PostListViewModel: ObservableObject {
  @Published var posts: [ItemInfo] = []
  @Published var isLoadingPage = false

  private let ref = Database.root
  private var postListRef: DatabaseReference?
  private var storyType: StoriesTypes?
  private var currentItem: Int = 0
  private var canLoadMoreItems = true

  init(forStoryType type: StoriesTypes) {
    let clock = ContinuousClock()
    Task {
      let result = await clock.measure {
        await genInitializePosts(forStoryType: type)
      }
      debugPrint(result)
    }
  }

  func loadMoreContentIfNeeded(currentItem item: ItemInfo? = nil) async {
    guard let postListRef = postListRef else { return }
    guard let item = item else {
      await genLoadMorePosts(from: postListRef, numberOfPosts: 10)
      return
    }

    let thresholdIndex = posts.index(posts.endIndex, offsetBy: -5)
    if posts.firstIndex(where: { $0.id == item.id }) == thresholdIndex {
      await genLoadMorePosts(from: postListRef, numberOfPosts: 10)
    }
  }

  func refreshPostList() async {
    currentItem = 0
    canLoadMoreItems = true
    guard let storyType = storyType else { return }
    await genInitializePosts(forStoryType: storyType)
  }

  // MARK: - Private functions

  private func genInitializePosts(forStoryType type: StoriesTypes) async {
    switch type {
    case .topStories:
      postListRef = ref.child("v0/topstories")
    case .newStories:
      postListRef = ref.child("v0/newstories")
    case .bestStories:
      postListRef = ref.child("v0/beststories")
    }
    guard let postListRef = postListRef else { return }
    await genLoadMorePosts(from: postListRef, numberOfPosts: 15)
  }

  @MainActor
  private func genLoadMorePosts(from ref: DatabaseReference, numberOfPosts count: Int) async {
    guard !isLoadingPage else { return }
    guard currentItem >= 0 else { return }

    isLoadingPage = true

    do {
      async let snapshot = try await ref
        .queryEnding(atValue: currentItem)
        .queryLimited(toFirst: UInt(count - 1))
        .getData()
      guard let snapshotVal = try await snapshot.value as? [Int] else { return }
      Task {
        posts = try await snapshotVal.concurrentCompactMap { value throws in
          await PostInfo(value)
        }
        currentItem += count
        isLoadingPage = false
      }
    } catch {
      print(error.localizedDescription)
      return
    }
  }

  private func genPostsInfo() async throws -> [ItemInfo] {
    await posts.asyncCompactMap {
      await PostInfo($0.delegate.itemData.id)
    }
  }

  func onViewDisappear() {
    ref.removeAllObservers()
  }
}
