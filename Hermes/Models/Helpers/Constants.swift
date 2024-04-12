//
//  Constants.swift
//  Hermes for Hacker News 2
//
//  Created by Cory Ginsberg on 4/3/24.
//

import Foundation
import OSLog
import SwiftUI

typealias HNID = Int

enum C {
  static let maxRequestChars = 4094
  static let angoliaBaseUrl = "http://hn.algolia.com/api/v1/search?"
  static let urlSizeBreathingRoom = 50
}

public extension Logger {
  init(category: String) {
    self.init(subsystem: Bundle.main.bundleIdentifier ?? "com.coryginsberg.Hermes", category: category)
  }
}

extension View {
  func log(category: String? = nil) -> os.Logger {
    os.Logger(category: category ?? String(describing: type(of: self)))
  }
}
