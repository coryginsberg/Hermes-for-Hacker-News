//
//  Copyright (c) 2022 Cory Ginsberg.
//  Licensed under the Apache License, Version 2.0
//

import DomainParser
import FirebaseDatabase
import Foundation

// MARK: - PostViewModel

class PostViewModel: ObservableObject, Identifiable {
  private let ref = Database.root
  var itemID: HNID

  @Published var itemData: ItemData?

  init?(itemID: HNID) async throws {
    self.itemID = itemID
    itemData = nil
    try await getPostInfo()
  }

  func getPostInfo() async throws {
    await PostInfo(itemID)?.fetchItem(from: ref) { itemData in
      self.itemData = itemData
    }
  }
}
