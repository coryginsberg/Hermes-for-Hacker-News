//
// Copyright (c) 2023 - Present Cory Ginsberg
// Licensed under Apache License 2.0
//

import AlertToast
import SwiftUI

// MARK: - RootView

struct RootView: View {
  @State var alertViewModal: AlertViewModal = .init()

  var body: some View {
    TabView {
      PostView()
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
    }
    .accentColor(Color(.systemOrange))
    .environment(alertViewModal)
    .toast(isPresenting: $alertViewModal.show) {
      alertViewModal.alertToast
    }
  }
}
