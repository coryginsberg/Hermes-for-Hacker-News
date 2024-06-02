//
// Copyright (c) 2023 - Present Cory Ginsberg
// Licensed under Apache License 2.0
//

import Foundation
import SwiftUI

extension View {
  /// Applies the given transform if the given condition evaluates to `true`.
  ///
  /// Shamelessly taken from
  /// [https://www.avanderlee.com/swiftui/conditional-view-modifier/](https://www.avanderlee.com/swiftui/conditional-view-modifier/)
  ///
  /// - Parameters:
  ///   - condition: The condition to evaluate.
  ///   - transform: The transform to apply to the source `View`.
  /// - Returns: Either the original `View` or the modified `View` if the condition is `true`.
  @ViewBuilder
  func `if`<Content: View>(_ condition: @autoclosure () -> Bool, transform: (Self) -> Content) -> some View {
    if condition() {
      transform(self)
    } else {
      self
    }
  }
}
