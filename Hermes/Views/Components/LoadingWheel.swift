//
// Copyright (c) 2023 - Present Cory Ginsberg
// Licensed under Apache License 2.0
//

import Foundation
import SwiftUI

struct LoadingWheel: View {
  var body: some View {
    Section {
      ProgressView()
        .progressViewStyle(.circular)
        .frame(
          maxWidth: .infinity, minHeight: 100
        )
        .listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
        .listRowSeparator(.hidden)
        .listSectionSeparator(.hidden)
        .listRowBackground(Color.clear)
        .id(UUID())
    }
  }
}
