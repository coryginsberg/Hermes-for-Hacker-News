//
//  Copyright (c) 2022 Cory Ginsberg.
//  Licensed under the Apache License, Version 2.0
//

import FirebaseDatabase

// MARK: - ItemInfoProtocol

protocol ItemInfoProtocol {
  var itemData: ItemData { get set }

  func fetchItem(from ref: DatabaseReference, completion: @escaping (ItemData) -> Void) async
}

// MARK: - ItemInfo

class ItemInfo: Identifiable, ItemInfoProtocol {
  // abstract
  var delegate: ItemInfoProtocol!
  let ref = Database.root
  init(itemData: ItemData) {
    self.itemData = itemData
  }

  func getItemInfo(for itemID: HNID) async {
    let postRef = ref.child("v0/item/\(itemID)")
    await delegate.fetchItem(from: postRef) { [self] item in
      delegate.itemData = item
    }
  }
  
  var itemData: ItemData = .init()
  
  func fetchItem(from ref: DatabaseReference, completion: @escaping (ItemData) -> Void) async {
    return
  }
}
