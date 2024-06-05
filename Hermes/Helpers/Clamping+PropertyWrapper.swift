//
// Copyright (c) 2023 - Present Cory Ginsberg
// Licensed under Apache License 2.0
//

import Foundation

/// Automatically "clamps" out-of-bounds values within the prescribed range.
///
/// - Parameters:
///   - range: The closed range that the returned value will be within.
/// - Returns: Either the value set initially or the closest value allowed within the range provided
extension Comparable {
  func clamped(to limits: ClosedRange<Self>) -> Self {
    return min(max(self, limits.lowerBound), limits.upperBound)
  }
}

#if swift(<5.1)
extension Strideable where Stride: SignedInteger {
  func clamped(to limits: CountableClosedRange<Self>) -> Self {
    return min(max(self, limits.lowerBound), limits.upperBound)
  }
}
#endif
