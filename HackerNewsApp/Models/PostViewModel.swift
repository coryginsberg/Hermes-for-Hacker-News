//
//  PostViewModel.swift
//  HackerNewsApp
//
//  Created by Cory Ginsberg on 10/12/22.
//

import FirebaseDatabase

class PostViewModel: ObservableObject, Identifiable {
  private let ref = Database.root
  
  @Published var itemID: Int
  
  init?(itemID: Int) {
    self.itemID = itemID
  }
  
//  func fetchComments() {
//    let commentRef = ref.child("post-comments").child(id)
//    refHandle = commentRef.observe(DataEventType.value, with: { snapshot in
//      guard let comments = snapshot.value as? [String: [String: Any]] else { return }
//      let sortedComments = comments.sorted(by: { $0.key > $1.key })
//      self.comments = sortedComments.compactMap { Comment(id: $0, dict: $1) }
//    })
//  }

}
