//
// Copyright (c) 2024 Cory Ginsberg.
// Licensed under the Apache License, Version 2.0
//

import FirebaseDatabase
import Foundation

enum PostType {
  static func fetchStory(
    from value: [String: Any],
    completion: @escaping (ItemData) -> Void
  ) async throws {
    var itemData: ItemData
    if let urlStr = value["url"] as? String, let url = URL(string: urlStr) {
      let faviconURL = try await ItemInfoHelper.loadFavicon(fromUrl: url)
      itemData = ItemData(forLink: url,
                          author: value["by"] as? String ?? "",
                          dead: value["dead"] as? Bool ?? false,
                          deleted: value["deleted"] as? Bool ?? false,
                          descendants: value["descendants"] as? Int ?? 0,
                          id: value["id"] as? HNID ?? 0,
                          kids: value["kids"] as? [HNID] ?? [],
                          score: value["score"] as? Int ?? 0,
                          time: ItemInfoHelper
                            .convertToDate(from: value["time"] as? Int ?? 0),
                          title: value["title"] as? String ?? "",
                          faviconURL: faviconURL)
    } else {
      itemData = ItemData(forStory: value["title"] as? String ?? "",
                          author: value["by"] as? String ?? "",
                          dead: value["dead"] as? Bool ?? false,
                          deleted: value["deleted"] as? Bool ?? false,
                          descendants: value["descendants"] as? Int ?? 0,
                          id: value["id"] as? HNID ?? 0,
                          kids: value["kids"] as? [HNID] ?? [],
                          score: value["score"] as? Int ?? 0,
                          text: value["text"] as? String ?? "",
                          time: ItemInfoHelper
                            .convertToDate(from: value["time"] as? Int ?? 0))
    }
    completion(itemData)
  }

  static func fetchJob(
    from value: [String: Any],
    completion: @escaping (ItemData) -> Void
  ) {
    completion(ItemData(
      forJob: value["by"] as? String ?? "",
      dead: value["dead"] as? Bool ?? false,
      deleted: value["deleted"] as? Bool ?? false,
      id: value["id"] as? HNID ?? 0,
      score: value["score"] as? Int ?? 0,
      text: value["text"] as? String ?? "",
      time: ItemInfoHelper.convertToDate(from: value["time"] as? Int ?? 0),
      title: value["title"] as? String ?? "",
      url: value["url"] as? URL
    ))
  }
}