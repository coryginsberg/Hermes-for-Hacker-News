//
//  CommentInfo.swift
//  HackerNewsApp
//
//  Created by Cory Ginsberg on 7/30/23.
//

import FirebaseDatabase
import Foundation

class CommentInfo: ItemInfo, ItemInfoProtocol {
  var itemData: ItemData = .init()
  var itemID: Int
  init?(for itemID: Int) async throws {
    self.itemID = itemID
    super.init()
    delegate = self
    try await getItemInfo(for: itemID)
  }

  func fetchItem(from ref: DatabaseReference, completion: @escaping (ItemData) -> Void) async {
    do {
      let snapshot = try await ref.getData()
      guard let value = snapshot.value as? [String: Any] else { return }
      guard let postType = value["type"] as? ItemData.TypeVal else { return }
      guard postType == .comment else { return }
      completion(ItemData(
        forComment: value["by"] as? String ?? "",
        descendants: value["descendants"] as? Int ?? 0,
        dead: value["dead"] as? Bool ?? false,
        deleted: value["deleted"] as? Bool ?? false,
        id: value["id"] as? Int ?? 0,
        kids: value["kids"] as? [Int] ?? [],
        parent: value["parent"] as? Int ?? 0,
        score: value["score"] as? Int ?? 0,
        text: value["text"] as? String ?? "",
        time: ItemInfoHelper.convertToDate(from: value["time"] as? Int ?? 0)
      ))
    } catch {
      print("Error fetching comment: \(error.localizedDescription)")
      return
    }
  }
}
