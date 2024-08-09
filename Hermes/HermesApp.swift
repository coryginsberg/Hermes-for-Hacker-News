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
    let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)

    do {
      ValueTransformer.setValueTransformer(UIColorValueTransformer(),
                                           forName: NSValueTransformerName("UIColorValueTransformer"))
      return try ModelContainer(for: schema, configurations: [modelConfiguration])
    } catch {
      fatalError("Could not create ModelContainer: \(error)")
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
