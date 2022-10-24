//
//  Copyright (c) 2022 Cory Ginsberg.
//  Licensed under the Apache License, Version 2.0
//

import SwiftUI

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

struct ProfileView_Previews: PreviewProvider {
  static var previews: some View {
    ProfileView()
  }
}
