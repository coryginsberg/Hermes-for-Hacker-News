//
//  Copyright (c) 2022 Cory Ginsberg.
//  Licensed under the Apache License, Version 2.0
//

import FirebaseDatabase

class PostListViewModel: ObservableObject {
  @Published var posts: [ItemInfo] = []

  private let ref = Database.root
  private var refHandle: DatabaseHandle?

  func getPosts(storiesTypes: StoriesTypes) {
    switch storiesTypes {
    case .topStories:
      let postListRef = ref.child("v0/topstories")
      fetchPosts(from: postListRef, for: storiesTypes)
    case .newStories:
      let postListRef = ref.child("v0/newstories")
      fetchPosts(from: postListRef, for: storiesTypes)
    case .bestStories:
      let postListRef = ref.child("v0/beststories")
      fetchPosts(from: postListRef, for: storiesTypes)
    }
  }

  private func fetchPosts(from ref: DatabaseReference, for storiesTypes: StoriesTypes) {
    ref.getData() { error, snapshot in
      guard error == nil else {
        print(error!.localizedDescription)
        return;
      }
      guard let value = snapshot?.value as? [Int] else { return }
      self.posts = value.compactMap { ItemInfo(itemID: $0) }
    }
  }

  func onViewDisappear() {
    ref.removeAllObservers()
  }
}
