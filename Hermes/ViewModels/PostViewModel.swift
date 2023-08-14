//
//  Copyright (c) 2022 Cory Ginsberg.
//  Licensed under the Apache License, Version 2.0
//

import FirebaseDatabase
import Foundation

class PostViewModel: ObservableObject, Identifiable {
  private let ref = Database.root
  var itemID: Int

  @Published var itemData: ItemData?

  init?(itemID: Int) async throws {
    self.itemID = itemID
    itemData = nil
    try await getPostInfo()
  }

  func getPostInfo() async throws {
    try await PostInfo(itemID)?.fetchItem(from: ref) { itemData in
      self.itemData = itemData
    }
  }
}
