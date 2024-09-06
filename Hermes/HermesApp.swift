//
// Copyright (c) 2023 - Present Cory Ginsberg
// Licensed under Apache License 2.0
//

import SwiftData
import SwiftUI

// MARK: - HermesApp

@main
struct HermesApp: App {
  var sharedModelContainer: ModelContainer = {
    let schema = Schema([
      Author.self,
      Comment.self,
      Post.self,
    ])
    let modelConfiguration = ModelConfiguration(
      schema: schema,
      isStoredInMemoryOnly: false
    )

    do {
      return try ModelContainer(
        for: schema,
        configurations: [modelConfiguration]
      )
    } catch {
      let urlApp = FileManager.default.urls(for: .applicationSupportDirectory, in: .userDomainMask).last
      // swiftlint:disable:next force_unwrapping
      let url = urlApp!.appendingPathComponent("default.store")
      if FileManager.default.fileExists(atPath: url.path) {
        fatalError("Could not create ModelContainer: \(error). Try clearing the swiftdata db at \(url.absoluteString)")
      }
      fatalError("Could not create ModelContainer: \(error).")
    }
  }()

  var body: some Scene {
    WindowGroup {
      RootView()
    }
    .modelContainer(sharedModelContainer)
  }
}

extension HermesApp: Logging {
  var category: String {
    "Entry Point"
  }
}
