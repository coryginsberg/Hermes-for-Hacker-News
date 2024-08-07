//
// Copyright (c) 2023 - Present Cory Ginsberg
// Licensed under Apache License 2.0
//

import Foundation
import SwiftUI

typealias HNID = Int

enum C {
  static let maxRequestChars = 4094
  static let angoliaBaseUrl = "http://hn.algolia.com/api/v1/search?"
  static let urlSizeBreathingRoom = 50
}

// extension View {
//  func log(category: String? = nil) -> Logger {
//    Logger(category: category ?? String(describing: type(of: self)))
//  }
// }
