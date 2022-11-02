//
//  Copyright (c) 2022 Cory Ginsberg.
//  Licensed under the Apache License, Version 2.0
//

import FirebaseDatabase
import Foundation

class ItemInfo: ObservableObject, Identifiable {
  private let ref = Database.root
  var itemID: Int
  var handle: DatabaseHandle?

  @Published var itemData: ItemData?

  init?(itemID: Int) {
    self.itemID = itemID
    itemData = nil
    getItemInfo()
  }

  func getItemInfo() {
    let postRef = ref.child("v0/item/\(itemID)")
    fetchItem(from: postRef) { item in
      self.itemData = item
      print(item)
    }
  }

  private func fetchItem(from ref: DatabaseReference, completion: @escaping (ItemData) -> Void) {
    ref.getData() { error, snapshot in
      guard error == nil else {
        print(error!.localizedDescription)
        return;
      }
      guard let value = snapshot?.value as? [String: Any] else { return }
      let itemData = ItemData(
        author: value["by"] as? String ?? "",
        descendants: value["descendants"] as? Int,
        dead: value["dead"] as? Bool ?? false,
        deleted: value["deleted"] as? Bool ?? false,
        id: (value["id"] as? Int)!,
        kids: value["kids"] as? [Int],
        parent: value["parent"] as? Int,
        parts: value["parts"] as? [Int],
        poll: value["poll"] as? Int,
        score: value["score"] as? Int ?? 0,
        text: value["text"] as? String ?? "",
        time: self.calcTimeAgo(from: value["time"] as? Int ?? 0),
        title: value["title"] as? String ?? "",
        type: (value["type"] as? String)!,
        url: value["url"] as? String
      )
      completion(itemData)
    }
  }

  private func calcTimeAgo(from timePublished: Int) -> String {
    let datePublished = Date(timeIntervalSince1970: TimeInterval(timePublished))
    let components = Calendar(identifier: .gregorian)
      .dateComponents(
        [.minute, .hour, .day, .month, .year],
        from: datePublished,
        to: Date()
      )

    switch components {
    case let component where component.year! > 0:
      return "\(components.year!)y"
    case let component where component.month! > 0:
      return "\(components.month!)mo"
    case let component where component.day! > 0:
      return "\(components.day!)d"
    case let component where component.hour! > 0:
      return "\(components.hour!)h"
    case let component where component.minute! > 0:
      return "\(components.minute!)m"
    default:
      return "<1m"
    }
  }
}
