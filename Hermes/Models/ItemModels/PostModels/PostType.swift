//
// Copyright (c) 2024 Cory Ginsberg.
// Licensed under the Apache License, Version 2.0
//

import FirebaseDatabase
import Foundation

enum PostType {
  static func fetchStory(
    from value: [String: Any],
    completion: @escaping (PostData) -> Void
  ) async throws {
    let url = genUrl(from: value["url"] as? String)
    let faviconUrl: URL? = if let url {
      try await ItemInfoHelper
        .loadFavicon(fromUrl: url)
    } else { nil }

    completion(PostData(
      author: value["by"] as? String ?? "",
      dead: value["dead"] as? Bool ?? false,
      deleted: value["deleted"] as? Bool ?? false,
      descendants: value["descendants"] as? Int ?? 0,
      id: value["id"] as? HNID ?? 0,
      kids: value["kids"] as? [HNID] ?? [],
      score: value["score"] as? Int ?? 0,
      text: value["text"] as? String ?? nil,
      time: ItemInfoHelper
        .convertToDate(from: value["time"] as? Int ?? 0),
      title: value["title"] as? String ?? "",
      url: url,
      faviconUrl: faviconUrl
    ))

    func genUrl(from urlStr: String?) -> URL? {
      guard let urlStr = urlStr,
            let url = URL(string: urlStr)
      else {
        return nil
      }
      return url
    }
  }

  static func fetchJob(
    from value: [String: Any],
    completion: @escaping (JobData) -> Void
  ) {
    completion(JobData(
      author: value["by"] as? String ?? "",
      dead: value["dead"] as? Bool ?? false,
      deleted: value["deleted"] as? Bool ?? false,
      id: value["id"] as? HNID ?? 0,
      score: value["score"] as? Int ?? 0,
      text: value["text"] as? String ?? "",
      time: ItemInfoHelper.convertToDate(from: value["time"] as? Int ?? 0),
      title: value["title"] as? String ?? ""
    ))
  }
}
