//
//  Copyright (c) 2022 Cory Ginsberg.
//  Licensed under the Apache License, Version 2.0
//

import SwiftUI

struct InboxView: View {
  let title: String = "Inbox"
  var body: some View {
    NavigationView {
      Text("You have {0} messages")
        .navigationTitle(title)
    }
  }
}

struct InboxView_Previews: PreviewProvider {
  static var previews: some View {
    InboxView()
  }
}
