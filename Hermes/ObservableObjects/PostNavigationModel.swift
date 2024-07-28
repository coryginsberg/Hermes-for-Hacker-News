//
// Copyright (c) 2023 - Present Cory Ginsberg
// Licensed under Apache License 2.0
//

import Foundation
import SwiftData
import SwiftUI

extension PostView {
  @Observable class NavigationModel {
    var urlPath: [URL] = []
  }

  @Observable
  class ViewModel {
    var searchTags: [Tags] = [.front_page]
    var searchQuery: String = ""
    var numericFilters: String = ""
    var pageNumber: Int = 0
    var hitsPerPage: Int = 30
  }
}

extension PostView.ViewModel {
  // swiftlint:disable identifier_name
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
  // swiftlint:enable identifier_name
}
