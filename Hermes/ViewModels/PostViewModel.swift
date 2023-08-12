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

  init?(itemID: Int) {
    self.itemID = itemID
    itemData = nil
    getPostInfo()
  }

  func getPostInfo() {
    let postRef = ref.child("v0/item/\(itemID)")
    fetchPost(from: postRef)
  }

  private func fetchPost(from ref: DatabaseReference) {
    ref.observeSingleEvent(
      of: .value,
      with: { snapshot in
        guard let value = snapshot.value as? [String: Any] else { return }
        self.itemData = ItemData(
          author: value["by"] as? String ?? "",
          descendants: value["descendants"] as? Int,
          dead: value["dead"] as? Bool ?? false,
          deleted: value["deleted"] as? Bool ?? false,
          id: (value["id"] as? Int)!,
          kids: value["kids"] as? [Int],
          parent: value["parent"] as? Int,
          parts: value["parts"] as? [Int],
          poll: value["poll"] as? Int,
          score: (value["score"] as? Int)!,
          text: value["text"] as? String ?? "",
          time: self.calcTimeAgo(from: value["time"] as? Int ?? 0),
          title: value["title"] as? String ?? "",
          type: ItemData.TypeVal(rawValue: value["type"] as! String)!,
          url: value["url"] is String ? URL(string: value["url"] as! String) : nil,
          faviconURL: nil
        )
      }
    )
  }

  private func calcTimeAgo(from timePublished: Int) -> Date {
    let datePublished = Date(timeIntervalSince1970: TimeInterval(timePublished))
    return Calendar(identifier: .gregorian)
      .dateComponents(
        [.minute, .hour, .day, .month, .year],
        from: datePublished,
        to: Date()
      ).date ?? Date()

//    switch components {
//    case let component where component.year! > 0:
//      return "\(components.year!)y"
//    case let component where component.month! > 0:
//      return "\(components.month!)mo"
//    case let component where component.day! > 0:
//      return "\(components.day!)d"
//    case let component where component.hour! > 0:
//      return "\(components.hour!)h"
//    case let component where component.minute! > 0:
//      return "\(components.minute!)m"
//    default:
//      return "<1m"
//    }
  }
}
