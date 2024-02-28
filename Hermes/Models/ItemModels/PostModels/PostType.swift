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
    let url: URL? = if let urlStr = value["url"] as? String {
      URL(string: urlStr)
    } else { nil }
    let faviconUrl = url != nil ? try await ItemInfoHelper
      .loadFavicon(fromUrl: url!) : nil

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
