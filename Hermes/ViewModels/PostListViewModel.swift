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
  private var currentItem: UInt = 0
  private var canLoadMoreItems = true

  init(forStoryType type: StoriesTypes) {
    Task {
      await genInitializePosts(forStoryType: type)
    }
  }

  func loadMoreContentIfNeeded(currentItem item: ItemInfo? = nil) async {
    guard let postListRef = postListRef else { return }
    guard let item = item else {
      await genLoadMorePosts(from: postListRef, numberOfPosts: 15)
      return
    }

    let thresholdIndex = posts.index(posts.endIndex, offsetBy: -10)
    if posts.firstIndex(where: { $0.id == item.id }) == thresholdIndex {
      await genLoadMorePosts(from: postListRef, numberOfPosts: 15)
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
    currentItem = 0
    await genLoadMorePosts(from: postListRef, numberOfPosts: 35)
  }

  @MainActor
  private func genLoadMorePosts(from ref: DatabaseReference, numberOfPosts count: UInt) async {
    guard canLoadMoreItems else { return }
    guard !isLoadingPage else { return }
    isLoadingPage = true
    do {
      async let snapshot = try await ref
        .queryLimited(toFirst: currentItem + count)
        .getData()
      guard let snapshotVal = try await snapshot.value as? [Int] else { return }
      Task {
        posts = try await snapshotVal.concurrentCompactMap { value throws in
          await PostInfo(value)
        }
        currentItem += count
        isLoadingPage = false
        if (currentItem >= 500) {
          canLoadMoreItems = false
        }
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
