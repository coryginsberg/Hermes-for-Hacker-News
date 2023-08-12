//
//  HermesApp.swift
//  Hermes
//
//  Created by Cory Ginsberg on 8/12/23.
//

import FirebaseCore
import SwiftUI

// MARK: - AppDelegate

class AppDelegate: NSObject, UIApplicationDelegate {
  func application(_: UIApplication,
                   didFinishLaunchingWithOptions _: [UIApplication.LaunchOptionsKey: Any]? = nil) -> Bool
  {
    print("Hermes is starting up. ApplicationDelegate didFinishLaunchingWithOptions.")
    FirebaseApp.configure()
    return true
  }
}

// MARK: - HermesApp

@main
struct HermesApp: App {
  @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate

  var body: some Scene {
    WindowGroup {
      RootView()
    }
  }
}
