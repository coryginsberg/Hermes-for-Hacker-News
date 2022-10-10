//
//  Hacker_NewsApp.swift
//  Hacker News
//
//  Created by Cory Ginsberg on 9/30/22.
//

import SwiftUI
import FirebaseCore

@main
struct Hacker_NewsApp: App {
  init() {
    FirebaseApp.configure()
  }

  var body: some Scene {
    WindowGroup {
      ContentView()
    }
  }
}
