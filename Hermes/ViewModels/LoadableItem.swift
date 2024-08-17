//
// Copyright (c) 2023 - Present Cory Ginsberg
// Licensed under Apache License 2.0
//

import Foundation

@Observable
class LoadableItemState<T> {
  indirect enum State {
    case idle
    case loading
    case loaded(T?)
    case empty
    case failed(Error)
  }

  var state = State.idle
}

protocol LoadableItem {
  associatedtype TLoadFrom
  func load(from type: TLoadFrom, isPreview: Bool) async
}
