//
// Copyright (c) 2024 Cory Ginsberg.
// Licensed under the Apache License, Version 2.0
//

import FirebaseDatabase
import Foundation

class PostInfo: ItemInfo {
  var itemID: HNID
  init?(_ itemID: HNID) async throws {
    self.itemID = itemID
    super.init(itemData: .init())
    delegate = self
    await getItemInfo(for: itemID)
  }

  override func fetchItem(
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
