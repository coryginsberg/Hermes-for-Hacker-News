//
//  Copyright (c) 2022 Cory Ginsberg.
//  Licensed under the Apache License, Version 2.0
//

import FirebaseDatabase

class PostListViewModel: ObservableObject {
  @Published var items: [ItemInfo] = []
  @Published var isLoadingPage = false

  private let ref = Database.root
  private var itemListRef: DatabaseReference?
  private var storyType: StoriesTypes? = nil
  private var currentItem: UInt = 0
  private var canLoadMoreItems = true

  init(forStoryType storyType: StoriesTypes? = nil) {
    Task {
      do {
        try await genInitializePosts(forStoryType: storyType)
      } catch ValidationError.storyTypeRequired {
        print("Error: Tried to generate a story without defining the story type");
      }
    }
  }

  func loadMoreContentIfNeeded(currentItem item: ItemInfo? = nil) async {
    guard let postListRef = itemListRef else { return }
    guard let item = item else {
      await genLoadMorePosts(from: postListRef, numberOfPosts: 15)
      return
    }

    let thresholdIndex = items.index(items.endIndex, offsetBy: -10)
    if items.firstIndex(where: { $0.id == item.id }) == thresholdIndex {
      await genLoadMorePosts(from: postListRef, numberOfPosts: 15)
    }
  }

  func refreshPostList() async throws {
    currentItem = 0
    canLoadMoreItems = true
    guard let storyType = storyType else { return }
    try await genInitializePosts(forStoryType: storyType)
  }

  // MARK: - Private functions

  private func genInitializePosts(forStoryType storyType: StoriesTypes? = nil) async throws {
    switch storyType {
    case .topStories:
      itemListRef = ref.child("v0/topstories")
    case .newStories:
      itemListRef = ref.child("v0/newstories")
    case .bestStories:
      itemListRef = ref.child("v0/beststories")
    case .none:
      throw ValidationError.storyTypeRequired
    }
    guard let postListRef = itemListRef else { return }
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
        items = try await snapshotVal.concurrentCompactMap { value throws in
            await PostInfo(HNID(value))
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
    await items.asyncCompactMap {
      await PostInfo($0.delegate.itemData.id)
    }
  }

  func onViewDisappear() {
    ref.removeAllObservers()
  }
}
