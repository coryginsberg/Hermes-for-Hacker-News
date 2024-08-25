//
// Copyright (c) 2023 - Present Cory Ginsberg
// Licensed under Apache License 2.0
//

extension Array where Element == HNID {
  func containsItem(_ id: HNID) -> Bool {
    contains { $0 == id }
  }
}
