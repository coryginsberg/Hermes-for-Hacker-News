//
//  Copyright (c) 2022 Cory Ginsberg.
//  Licensed under the Apache License, Version 2.0
//

import SwiftUI

// MARK: - ProfileView

struct ProfileView: View {
  let title: String = "My Profile"

  var body: some View {
    NavigationView {
      Text("{Username} has {x} karma").font(.title)
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

// MARK: - ProfileView_Previews

struct ProfileView_Previews: PreviewProvider {
  static var previews: some View {
    ProfileView()
  }
}
