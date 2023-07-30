//
//  Copyright (c) 2022 Cory Ginsberg.
//  Licensed under the Apache License, Version 2.0
//

import FaviconFinder
import FirebaseDatabase
import Foundation
import SwiftUI

protocol ItemInfoProtocol {
  var itemData: ItemData { get set }

  func fetchItem(from ref: DatabaseReference, completion: @escaping (ItemData) -> Void) async
}

class ItemInfo: Identifiable { // abstract
  var delegate: ItemInfoProtocol!
  let ref = Database.root

  func getItemInfo(for itemId: Int) async {
    let postRef = ref.child("v0/item/\(itemId)")
    await delegate.fetchItem(from: postRef) { [self] item in
      delegate.itemData = item
    }
  }
}
