//
// Copyright (c) 2023 - Present Cory Ginsberg
// Licensed under Apache License 2.0
//

import SwiftUI

extension Text {
  func secondaryStyle() -> some View {
    let secondaryColor = Color(uiColor: .secondaryLabel)

    return allowsTightening(true)
      .frame(maxWidth: .infinity, alignment: .leading)
      .font(.footnote)
      .foregroundColor(secondaryColor)
      .lineLimit(1)
  }

  func commentStyle() -> some View {
    let primaryColor = Color(uiColor: .label)

    return foregroundColor(primaryColor)
      .multilineTextAlignment(.leading)
      .padding(.bottom, 6.0)
      .allowsTightening(true)
      .frame(maxWidth: .infinity, alignment: .leading)
      .dynamicTypeSize(.medium)
      .textSelection(.enabled)
      .font(.body)
  }
}
