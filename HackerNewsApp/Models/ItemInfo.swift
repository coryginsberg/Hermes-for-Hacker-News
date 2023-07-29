//
//  Copyright (c) 2022 Cory Ginsberg.
//  Licensed under the Apache License, Version 2.0
//

import FaviconFinder
import FirebaseDatabase
import Foundation
import SwiftUI

final class ItemInfo: Identifiable {
  private let ref = Database.root
  var itemID: Int
  var handle: DatabaseHandle?

  @Published var itemData: ItemData?

  init?(itemID: Int) async {
    self.itemID = itemID
    itemData = nil
    await getItemInfo()
  }

  func getItemInfo() async {
    let postRef = ref.child("v0/item/\(itemID)")
    await fetchItem(from: postRef) { item in
      self.itemData = item
    }
  }

  private func fetchItem(from ref: DatabaseReference, completion: @escaping (ItemData) -> Void) async {
    do {
      let snapshot = try await ref.getData()
      guard let value = snapshot.value as? [String: Any] else { return }

      let url = value["url"] as? String
      let faviconUrl =
        url != nil ? try await loadFavicon(fromUrl: URL(string: url ?? "")!) : nil

      let itemData = ItemData(
        author: value["by"] as? String ?? "",
        descendants: value["descendants"] as? Int,
        dead: value["dead"] as? Bool ?? false,
        deleted: value["deleted"] as? Bool ?? false,
        id: value["id"] as? Int ?? 0,
        kids: value["kids"] as? [Int],
        parent: value["parent"] as? Int,
        parts: value["parts"] as? [Int],
        poll: value["poll"] as? Int,
        score: value["score"] as? Int ?? 0,
        text: value["text"] as? String ?? "",
        time: calcTimeAgo(from: value["time"] as? Int ?? 0),
        title: value["title"] as? String ?? "",
        type: (value["type"] as? String) ?? "",
        url: url,
        faviconUrl: faviconUrl
      )

      completion(itemData)
    } catch {
      print("Error fetching item: \(error.localizedDescription)")
      return
    }
  }

  private func loadFavicon(fromUrl url: URL) async throws -> URL {
    do {
      let favicon = try await FaviconFinder(url: url, downloadImage: false).downloadFavicon()
      return favicon.url
    } catch {
      print("Error loading favicon: \(error.localizedDescription)")
      guard let url = Bundle.main.url(forResource: "awkward-monkey", withExtension: "png") else {
        throw URLError(.fileDoesNotExist)
      }
      return url
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
