//
// Copyright (c) 2023 - Present Cory Ginsberg
// Licensed under Apache License 2.0
//

import Defaults
import Foundation

typealias Defaults = _Defaults
typealias Default = _Default

extension Defaults.Keys {
  static let viewedPosts = Key<Set<HNID>>("viewedPosts", default: [])
}
