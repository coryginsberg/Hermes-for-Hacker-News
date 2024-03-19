//
// Copyright (c) 2024 Cory Ginsberg.
// Licensed under the Apache License, Version 2.0
//

import FirebaseDatabase
import Foundation

// MARK: - Constants

private enum Constants {
  static let loadCount: UInt = 30
  static let thresholdCount = 15
  static let maxPostsAvailable = 500
}

class PostListViewModel: ObservableObject {
  enum Status {
    case loading
    case loaded
    case error(Error)
    case noStoryTypeError
  }

  private var ref = Database.root
  private var storyType: StoriesTypes?

  private var totalPostsAvailable: Int = Constants.maxPostsAvailable

  private var numPostsLoaded: Int?
  private var currentItem: HNID = 0

  @Published var items: [PostInfo] = []
  @Published var status: Status = .loading

  init(forStoryType storyType: StoriesTypes? = nil) {
    self.storyType = storyType
  }

  func setStoryType(_ storyType: StoriesTypes?) {
    self.storyType = storyType
    do {
      switch self.storyType {
      case .topStories:
        ref = ref.child("v0/topstories")
      case .newStories:
        ref = ref.child("v0/newstories")
      case .bestStories:
        ref = ref.child("v0/beststories")
      case .none:
        throw StoryListError.storyTypeRequired
      }
    } catch StoryListError.storyTypeRequired {
      status = .noStoryTypeError
    } catch {
      status = .error(error)
    }
    print("Story type set to \(self.storyType.debugDescription)")
  }

  @MainActor
  func genQueryInitialPosts() async {
    print("Querying initial posts")
    do {
      if storyType == nil { throw StoryListError.storyTypeRequired }
      await genRequestPosts()
    } catch StoryListError.storyTypeRequired {
      print("Tried pulling posts without specifying a story type path")
    } catch {
      print(error.localizedDescription)
      status = .error(error)
    }
  }

  func genRefreshPostList() async {
    print("Refreshing")
    currentItem = 0
    await genQueryInitialPosts()
  }

  func genRequestMoreItemsIfNeeded(index: Int) async throws {
    print("Checking if should request more items")
    guard let numPostsLoaded = numPostsLoaded else {
      return
    }
    print("\(numPostsLoaded) posts loaded")
    if calcThresholdMet(numPostsLoaded, index) &&
      morePostsRemaining(numPostsLoaded, totalPostsAvailable) {
      // Request next set of posts
      await genRequestPosts()
    } else {
      throw StoryListError.noMorePosts
    }
  }

//  func genLoadMoreContentIfNeeded(currentItem item: ItemInfo? = nil) async {
//    guard let postListRef = itemListRef else { return }
//    guard let item else {
//      await genLoadMorePosts(from: postListRef, numberOfPosts: Constants.initialCountToLoad)
//      return
//    }
//
//    let thresholdIndex = items.index(items?.endIndex, offsetBy: -10)
//    if items?.firstIndex(where: { $0.id == item.id }) == thresholdIndex {
//      await genLoadMorePosts(from: postListRef, numberOfPosts: 15)
//    }
//  }

  // MARK: - Private functions

//  private func genInitializePosts(forStoryType storyType: StoriesTypes? =
//    nil) async throws {
//    guard let postListRef = itemListRef else { return }
//    currentItem = 0
//    genRequestMorePosts(page: <#T##Int#>)
//    await genLoadMorePosts(from: postListRef, numberOfPosts: 35)
//  }

  private func calcThresholdMet(_ itemsLoadedCount: Int, _ index: Int) -> Bool {
    return (itemsLoadedCount - index) == Constants.thresholdCount
  }

  private func morePostsRemaining(_ itemsLoadedCount: Int, _ totalItemsAvailable: Int) -> Bool {
    return itemsLoadedCount < totalItemsAvailable
  }

  @MainActor
  private func genRequestPosts(
  ) async {
    print("Requesting posts")

    status = .loading
    do {
      guard let refUrl = URL(string: ref.url) else { throw StoryListError.databaseRefUrlNotFound }
      if refUrl.pathComponents.isEmpty { throw StoryListError.storyTypeRequired }

//      if currentItem == 0 {
//        async let snapshot = try await ref.queryLimited(toFirst: Constants.loadCount).getData()
//        guard let snapshotVal = try await snapshot.value as? [Int] else { return }
//      } else {
      async let snapshot = try await ref.queryLimited(toFirst: Constants.loadCount).getData()
      guard let snapshotVal = try await snapshot.value as? [Int] else { return }
//      }
      items = try await snapshotVal.concurrentCompactMap { value throws in
        try await PostInfo(HNID(value))
      }
      currentItem = items.last?.itemID ?? 0
      status = .loaded
    } catch StoryListError.storyTypeRequired {
      print("Tried pulling posts without specifying a story type path")
    } catch {
      print(error.localizedDescription)
      status = .error(error)
    }
    print("Finished requesting posts. \(items.count) loaded.")
  }

  func onViewDisappear() {
    ref.removeAllObservers()
  }
}
