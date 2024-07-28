//
// Copyright (c) 2023 - Present Cory Ginsberg
// Licensed under Apache License 2.0
//

import SwiftData
import SwiftUI

// MARK: - HermesApp

@main
struct HermesApp: App {
  @State private var postViewModel = PostView.ViewModel()

  let modelContainer: ModelContainer

  init() {
    do {
      modelContainer = try ModelContainer(for: Post.self)
    } catch {
      fatalError("Failed to create ModelContainer for ItemData: \(error)")
    }
  }

  var body: some Scene {
    WindowGroup {
      RootView().environment(postViewModel)
    }
    .modelContainer(modelContainer)
  }
}

extension HermesApp: Logging {
  var category: String {
    "Entry Point"
  }
}
