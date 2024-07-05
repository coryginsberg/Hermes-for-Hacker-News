//
// Copyright (c) 2023 - Present Cory Ginsberg
// Licensed under Apache License 2.0
//

import SwiftUI

// MARK: - InboxView

struct InboxView: View {
  let title: String = "Inbox"
  var body: some View {
    NavigationView {
      Text("You have {0} messages")
        .navigationTitle(title)
    }
  }
}

// MARK: - InboxView_Previews

struct InboxView_Previews: PreviewProvider {
  static var previews: some View {
    InboxView()
  }
}
