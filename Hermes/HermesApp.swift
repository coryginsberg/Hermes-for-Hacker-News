//
// Copyright (c) 2024 Cory Ginsberg.
// Licensed under the Apache License, Version 2.0
//

import OSLog
import SwiftData
import SwiftUI

<<<<<<< HEAD
// MARK: - AppDelegate

class AppDelegate: NSObject, UIApplicationDelegate {
  func application(
    _: UIApplication,
    didFinishLaunchingWithOptions _: [UIApplication.LaunchOptionsKey: Any]? =
      nil
  ) -> Bool {
    print(
      "Hermes is starting up. ApplicationDelegate didFinishLaunchingWithOptions."
    )
    FirebaseApp.configure()
    return true
  }
}

=======
>>>>>>> mvc-rewrite
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
