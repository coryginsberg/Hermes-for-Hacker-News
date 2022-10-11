//
//  Copyright (c) 2022 Cory Ginsberg.
//
//  Licensed under the Apache License, Version 2.0
//

import Foundation
import SwiftUI

struct PostsView: View {

  let title: String = "Posts"

  var body: some View {
    NavigationView {
      Text("hello world")
        .navigationTitle(title)
      .toolbar {
        ToolbarItemGroup(placement: .navigationBarTrailing) {

        }
      }
    }
  }
}

struct PostsView_Previews: PreviewProvider {
  static var previews: some View {
    PostsView()
  }
}

