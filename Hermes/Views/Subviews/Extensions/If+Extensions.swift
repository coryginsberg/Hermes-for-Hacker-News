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
  ///   - if: The transform to apply to the source `View` if `condition` is true.
  ///   - else: The transform to apply to the source `View` if `condition` is false.
  /// - Returns: Either the original `View` or the modified `View` if the condition is `true`.
  ///
  /// ```swift
  /// Text("Hello, World!")
  ///   .if(isTitle) { text in
  ///     text.fontWeight(.bold)
  ///   } else: {
  ///     text.fontWeight(.normal)
  ///   }
  /// ```
  @ViewBuilder
  func `if`<Content: View>(_ condition: @autoclosure () -> Bool,
                           if transformIf: (Self) -> Content,
                           else transformElse: ((Self) -> Content)? = nil) -> some View {
    if condition() {
      transformIf(self)
    } else if let transformElse {
      transformElse(self)
    } else {
      self
    }
  }
}
