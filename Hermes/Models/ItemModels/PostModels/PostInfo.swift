//
//  PostInfo.swift
//  HackerNewsApp
//
//  Created by Cory Ginsberg on 7/30/23.
//

import FirebaseDatabase
import Foundation

class PostInfo: ItemInfo, ItemInfoProtocol {
  var itemData: ItemData = .init()
  var itemID: HNID
  init?(_ itemID: HNID) async {
    self.itemID = itemID
    super.init()
    delegate = self
    await getItemInfo(for: itemID)
  }

  func fetchItem(
    from ref: DatabaseReference,
    completion: @escaping (ItemData) -> Void
  ) async {
    do {
      let snapshot = try await ref.getData()

      guard let value = snapshot.value as? [String: Any] else { return }
      guard let postType = ItemData.TypeVal(rawValue: value["type"] as! String)
      else { return }
      do {
        switch postType {
        case .story:
          try await PostType.fetchStory(from: value, completion: completion)
        case .job:
          PostType.fetchJob(from: value, completion: completion)
        case .poll:
          break
        case .pollopt:
          break
        default:
          return
        }
      } catch {
        print("Error fetching post: \(value)")
        return
      }
    } catch {
      print("Error fetching Posts: \(error.localizedDescription)")
      return
    }
  }
}
