//
// Copyright (c) 2023 - Present Cory Ginsberg
// Licensed under Apache License 2.0
//

import Foundation

@Observable
class LoadableItemState<TLoadingItem>: @unchecked Sendable {
  indirect enum State {
    case idle
    case loading
    case loadingProgress(Int)
    case loaded(TLoadingItem)
    case empty
    case failed(LoadableItemError)
  }

  var state = State.idle
}

protocol LoadableItem {
  associatedtype TLoadFrom
  func load(from type: TLoadFrom, isPreview: Bool) async
}

enum LoadableItemError: Error {
  case loadingError
  case notFound
}
