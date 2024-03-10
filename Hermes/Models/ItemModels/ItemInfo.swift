//
// Copyright (c) 2024 Cory Ginsberg.
// Licensed under the Apache License, Version 2.0
//

import FirebaseDatabase

// MARK: - ItemInfoProtocol

protocol ItemInfoProtocol {
  var itemData: ItemData { get set }

  func fetchItem(
    from ref: DatabaseReference,
    completion: @escaping (ItemData) -> Void
  ) async
}

// MARK: - ItemInfo Constants

private enum Constants {
  static let ref = Database.root
  static let url = "v0/item/"
}

// MARK: - ItemInfo

class ItemInfo: Identifiable, ItemInfoProtocol {
  // abstract
  var delegate: ItemInfoProtocol?
  init(itemData: ItemData) {
    self.itemData = itemData
  }

  func getItemInfo(for itemID: HNID) async {
    let postRef = Constants.ref.child("\(Constants.url)\(itemID)")
    await delegate?.fetchItem(from: postRef) { [self] item in
      delegate?.itemData = item
    }
  }

  var itemData: ItemData = .init()

  func fetchItem(
    from _: DatabaseReference,
    completion _: @escaping (ItemData) -> Void
  ) async {}
}
