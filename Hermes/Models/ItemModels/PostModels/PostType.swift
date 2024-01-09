//
//  StoryInfo.swift
//  HackerNewsApp
//
//  Created by Cory Ginsberg on 7/30/23.
//

import FirebaseDatabase
import Foundation

struct PostType {
  static func fetchStory(from value: [String: Any], completion: @escaping (ItemData) -> Void) async throws {
    var itemData: ItemData
    if let urlStr = value["url"] as? String, let url = URL(string: urlStr) {
      print(url)
      let faviconURL = try await ItemInfoHelper.loadFavicon(fromUrl: url)
      itemData = ItemData(forLink: url,
                          author: value["by"] as? String ?? "",
                          dead: value["dead"] as? Bool ?? false,
                          deleted: value["deleted"] as? Bool ?? false,
                          descendants: value["descendants"] as? Int ?? 0,
                          id: value["id"] as? HNID ?? 0,
                          score: value["score"] as? Int ?? 0,
                          time: ItemInfoHelper.convertToDate(from: value["time"] as? Int ?? 0),
                          title: value["title"] as? String ?? "",
                          faviconURL: faviconURL)
    } else {
      itemData = ItemData(forStory: value["title"] as? String ?? "",
                          author: value["by"] as? String ?? "",
                          dead: value["dead"] as? Bool ?? false,
                          deleted: value["deleted"] as? Bool ?? false,
                          descendants: value["descendants"] as? Int ?? 0,
                          id: value["id"] as? HNID ?? 0,
                          score: value["score"] as? Int ?? 0,
                          text: value["text"] as? String ?? "",
                          time: ItemInfoHelper.convertToDate(from: value["time"] as? Int ?? 0))
    }
    completion(itemData)
  }

  static func fetchJob(from value: [String: Any], completion: @escaping (ItemData) -> Void) {
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
