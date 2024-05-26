//
// Copyright (c) 2023 - Present Cory Ginsberg
// Licensed under Apache License 2.0
//

import OSLog
import SwiftData
import SwiftUI

// MARK: - HermesApp

@main
struct HermesApp: App {
  @State private var viewModel = ViewModel()

  let modelContainer: ModelContainer

  init() {
    do {
      modelContainer = try ModelContainer(for: Post.self)
    } catch {
      Logger(category: "HermesApp").fault("\(error)")
      fatalError("Failed to create ModelContainer for ItemData")
    }
  }

  var body: some Scene {
    WindowGroup {
      RootView().environment(viewModel)
    }
    .modelContainer(modelContainer)
  }
}
