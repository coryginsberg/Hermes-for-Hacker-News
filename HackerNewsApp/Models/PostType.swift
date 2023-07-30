//
//  StoryInfo.swift
//  HackerNewsApp
//
//  Created by Cory Ginsberg on 7/30/23.
//

import FirebaseDatabase
import Foundation

struct PostType {
  static func fetchStory(from value: [String: Any], completion: @escaping (ItemData) -> Void) async {
    do {
      let url = value["url"] as? URL
      var faviconUrl: URL?
      if url != nil {
        faviconUrl = try await ItemInfoHelper.loadFavicon(fromUrl: url!)
      }
      let itemData = ItemData(
        forStory: value["by"] as? String ?? "",
        dead: value["dead"] as? Bool ?? false,
        deleted: value["deleted"] as? Bool ?? false,
        id: value["id"] as? Int ?? 0,
        score: value["score"] as? Int ?? 0,
        text: value["text"] as? String ?? "",
        time: ItemInfoHelper.convertToDate(from: value["time"] as? Int ?? 0),
        title: value["title"] as? String ?? "",
        url: url,
        faviconUrl: faviconUrl
      )
      completion(itemData)
    } catch {
      print("Error fetching item: \(error.localizedDescription)")
      return
    }
  }
  
  static func fetchJob(from value: [String: Any], completion: @escaping (ItemData) -> Void) async {
    let url = value["url"] as? URL
    let itemData = ItemData(
      forJob: value["by"] as? String ?? "",
      dead: value["dead"] as? Bool ?? false,
      deleted: value["deleted"] as? Bool ?? false,
      id: value["id"] as? Int ?? 0,
      score: value["score"] as? Int ?? 0,
      text: value["text"] as? String ?? "",
      time: ItemInfoHelper.convertToDate(from: value["time"] as? Int ?? 0),
      title: value["title"] as? String ?? "",
      url: url
    )
    completion(itemData)
  }
}
