//
//  PostInfo.swift
//  HackerNewsApp
//
//  Created by Cory Ginsberg on 7/30/23.
//

import Foundation
import FirebaseDatabase

class PostInfo: ItemInfo, ItemInfoProtocol {
  var itemData: ItemData = ItemData()
  var itemId: Int
  init?(_ itemId: Int) async {
    self.itemId = itemId;
    super.init()
    delegate = self
    await getItemInfo(for: itemId)
  }
  
  func fetchItem(from ref: DatabaseReference, completion: @escaping (ItemData) -> Void) async {
    do {
      let snapshot = try await ref.getData()
      guard let value = snapshot.value as? [String: Any] else { return }
      guard let postType = ItemData.TypeVal(rawValue: value["type"] as! String) else { return }
      switch postType {
      case .story:
        await PostType.fetchStory(from: value, completion: completion)
      case .job:
        await PostType.fetchJob(from: value, completion: completion)
        break
      case .poll:
        break
      case .pollopt:
        break
      default:
        return
      }
    } catch {
      print("Error fetching Posts: \(error.localizedDescription)")
      return
    }
  }
}
