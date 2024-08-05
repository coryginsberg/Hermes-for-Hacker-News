//
// Copyright (c) 2023 - Present Cory Ginsberg
// Licensed under Apache License 2.0
//

import DomainParser
import Foundation
import UIKit

// MARK: - XCAsset local URL

/// See: https://stackoverflow.com/questions/21769092/can-i-get-a-nsurl-from-an-xcassets-bundle
public extension URL {
  @MainActor
  func isValidURL() async -> Bool {
    if let url = URL(string: absoluteString) {
      return UIApplication.shared.canOpenURL(url)
    }
    return false
  }

  /// Returns the root domain and the tld
  @available(macOS 13.0, iOS 16.0, tvOS 16.0, watchOS 9.0, *)
  var domain: String? {
    get async {
      guard await isValidURL() else {
        return await URL(string: "https://\(absoluteString)")?.domain
      }
      do {
        return try DomainParser()
          .parse(host: host() ?? "")?
          .domain
      } catch {
        return host
      }
    }
  }
}

extension URL {
  static func localURLForXCAsset(name: String) -> URL? {
    let fileManager = FileManager.default
    guard let cacheDirectory = fileManager.urls(
      for: .cachesDirectory,
      in: .userDomainMask
    ).first else { return nil }
    let url = cacheDirectory.appendingPathComponent("\(name).png")
    let path = url.path
    if !fileManager.fileExists(atPath: path) {
      guard let image = UIImage(named: name),
            let data = image.pngData() else { return nil }
      fileManager.createFile(atPath: path, contents: data, attributes: nil)
    }
    return url
  }
}
