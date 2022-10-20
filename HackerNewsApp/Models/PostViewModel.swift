//
//  Copyright (c) 2022 Cory Ginsberg.
//  Licensed under the Apache License, Version 2.0
//

import FirebaseDatabase
import FirebaseDatabaseSwift
import Foundation

class PostViewModel: ObservableObject, Identifiable {
  private let ref = Database.root
  var itemID: Int

  @Published var postData: PostData?

  init?(itemID: Int) {
    self.itemID = itemID
    postData = nil
    getPostInfo()
  }

  func getPostInfo() {
    let postRef = ref.child("v0/item/\(itemID)")
    fetchPost(from: postRef)
  }

  private func fetchPost(from ref: DatabaseReference) {
    ref.observeSingleEvent(of: .value, with: { snapshot in
      guard let value = snapshot.value as? [String: Any] else { return }
      print(value)
      self.postData = PostData(by: value["by"] as! String,
                               descendants: value["descendants"] as? Int,
                               id: (value["id"] as? Int)!,
                               kids: value["kids"] as? [Int],
                               score: value["score"] as? Int ?? 0,
                               time: (value["time"] as? Int ?? 0)!,
                               title: (value["title"] as? String)!,
                               type: (value["type"] as? String)!,
                               url: value["url"] as? String)
    })
  }
}
