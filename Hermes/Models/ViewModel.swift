//
// Copyright (c) 2023 - Present Cory Ginsberg
// Licensed under Apache License 2.0
//

import Foundation
import SwiftData

// swiftlint:disable identifier_name

@Observable
class ViewModel {
  enum Tags {
    case story
    case comment
    case poll
    case pollopt
    case show_hn
    case ask_hn
    case front_page
    case author_(username: String)
    case story_(id: Int) // HNID
  }

  var searchTags: [Tags] = [.front_page]
  var searchQuery: String = ""
  var numericFilters: String = ""
  var pageNumber: Int = 0
  var hitsPerPage: Int = 30
}

// swiftlint:enable identifier_name
