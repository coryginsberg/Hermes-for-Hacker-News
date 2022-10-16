//
//  PostListViewModel.swift
//  HackerNewsApp
//
//  Created by Cory Ginsberg on 10/12/22.
//

import Combine
import FirebaseDatabase


class PostListViewModel: ObservableObject {
  @Published var posts: [PostViewModel] = []
  
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
    // read data by listening for value events
    ref.observe(DataEventType.value, with: { snapshot -> Void in
      // retrieved data is of type dictionary of dictionary
      guard let value = snapshot.value as? [Int] else { return }
      // store content of sorted dictionary into "posts" variable
      self.posts = value.compactMap { PostViewModel(itemID: $0) }
    })
  }
  
  func onViewDisappear() {
    ref.removeAllObservers()
  }
}
