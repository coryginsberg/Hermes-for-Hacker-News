//
// Copyright (c) 2024 Cory Ginsberg.
// Licensed under the Apache License, Version 2.0
//

import AlertToast
import SwiftUI

// MARK: - RootView

struct RootView: View {
  @Environment(\.managedObjectContext) private var viewContext

  @StateObject var viewModal: AlertViewModal = .init()

  var body: some View {
    TabView {
      PostListView()
        .tabItem {
          Label("Posts", systemImage: "newspaper.fill")
        }
      InboxView()
        .tabItem {
          Label("Inbox", systemImage: "envelope.fill")
        }
      ProfileView()
        .tabItem {
          Label("Profile", systemImage: "person.crop.circle")
        }
      SettingsView()
        .tabItem {
          Label("Settings", systemImage: "gearshape.fill")
        }
    }.accentColor(Color(.systemOrange)).environmentObject(viewModal)
      .toast(isPresenting: $viewModal.show) {
        viewModal.alertToast
      }
  }
}

private let itemFormatter: DateFormatter = {
  let formatter = DateFormatter()
  formatter.dateStyle = .short
  formatter.timeStyle = .medium
  return formatter
}()

// MARK: - RootView_Previews

struct RootView_Previews: PreviewProvider {
  static var previews: some View {
    RootView()
  }
}