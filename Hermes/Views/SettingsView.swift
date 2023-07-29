//
//  Copyright (c) 2022 Cory Ginsberg.
//  Licensed under the Apache License, Version 2.0
//

import Foundation
import SwiftUI

struct SettingsView: View {
  let title: String = "Settings"

  struct Setting: Identifiable {
    let id = UUID()
    var name: String
  }

  var staff = [
    Setting(name: "Lorem Ipsum"),
    Setting(name: "Dolor sit amet"),
  ]

  @State var toggle: Bool = false

  var body: some View {
    NavigationView {
      List {
        ForEach(staff) { person in
          Toggle(person.name, isOn: $toggle)
        }
      }
      .navigationTitle(title)
      .toolbar {
        ToolbarItemGroup(placement: .navigationBarTrailing) {
          Button(action: {}, label: {
            Text("Logout")
          })
        }
      }
    }
  }
}

struct SettingsView_Previews: PreviewProvider {
  static var previews: some View {
    SettingsView()
  }
}
