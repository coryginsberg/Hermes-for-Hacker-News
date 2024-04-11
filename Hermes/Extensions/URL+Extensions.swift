//
<<<<<<< HEAD
//  URL+Extensions.swift
//  FaviconFinder
//
//  Created by William Lumley on 16/10/19.
//  Copyright © 2019 William Lumley. All rights reserved.
=======
// Copyright (c) 2024 Cory Ginsberg.
// Licensed under the Apache License, Version 2.0
>>>>>>> mvc-rewrite
//

import DomainParser
import Foundation
import UIKit

public extension URL {
  func isValidURL() -> Bool {
    if let url = URL(string: absoluteString) {
      return UIApplication.shared.canOpenURL(url)
    }
    return false
  }

  /// Returns the root domain and the tld
  @available(macOS 13.0, iOS 16.0, tvOS 16.0, watchOS 9.0, *)
  var domain: String? {
    guard isValidURL() else {
      return URL(string: "https://\(absoluteString)")?.domain
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
