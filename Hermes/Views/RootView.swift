//
// Copyright (c) 2023 - Present Cory Ginsberg
// Licensed under Apache License 2.0
//

import AlertToast
import SwiftUI

// MARK: - RootView

struct RootView: View {
  @Environment(\.managedObjectContext) private var viewContext
  @State private var viewModel = ViewModel()
  @StateObject var alertViewModal: AlertViewModal = .init()

  var body: some View {
    TabView {
      PostTabView()
        .tabItem {
          Label("Posts", systemImage: "newspaper.fill")
        }
        .environment(viewModel)
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
    .environmentObject(alertViewModal)
    .toast(isPresenting: $alertViewModal.show) {
      alertViewModal.alertToast
    }
  }
}

// MARK: - RootView_Previews

struct RootView_Previews: PreviewProvider {
  static var previews: some View {
    RootView()
  }
}
