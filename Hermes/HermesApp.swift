//
// Copyright (c) 2024 Cory Ginsberg.
// Licensed under the Apache License, Version 2.0
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
