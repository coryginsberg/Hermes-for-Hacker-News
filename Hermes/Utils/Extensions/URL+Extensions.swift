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
