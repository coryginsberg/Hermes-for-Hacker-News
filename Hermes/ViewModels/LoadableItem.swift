//
// Copyright (c) 2023 - Present Cory Ginsberg
// Licensed under Apache License 2.0
//

import Foundation

@MainActor
class LoadableItemState<T>: ObservableObject {
  indirect enum State {
    case idle
    case loading
    case loaded(T)
    case empty
    case failed(Error)
  }

  @Published var state = State.idle
}

@MainActor
protocol LoadableItem {
  associatedtype TLoadFrom
  func load(from type: TLoadFrom, isPreview: Bool) async
}
