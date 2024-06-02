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
@propertyWrapper
public struct Clamped<Value: Comparable> {
  private var value: Value
  private var range: ClosedRange<Value>

  public var wrappedValue: Value {
    get { value }
    set { value = clampedValue(for: newValue) }
  }
}

// MARK: - Init

public extension Clamped {
  init(
    wrappedValue defaultValue: Value,
    to range: ClosedRange<Value>
  ) {
    precondition(
      range.contains(defaultValue),
      """
      `\(defaultValue)` is not contained by this property's
      range of `\(range)`.
      """
    )

    self.value = defaultValue
    self.range = range
  }

  /// Clamps a property to a "Half-Open" Range.
  ///
  /// Example:
  ///
  ///     @Clamped(to: 1 ..< 1025)
  ///     var score: Int = 1024
  init(
    wrappedValue defaultValue: Value,
    to range: Range<Value>
  ) {
    precondition(
      range.lowerBound < range.upperBound,
      """
      The lower-bound of the range must be less than its upper-bound.
      """
    )

    let closedRange = ClosedRange(
      uncheckedBounds: (lower: range.lowerBound, upper: range.upperBound)
    )

    self.init(value: defaultValue, range: closedRange)
  }
}

// MARK: - Private Helpers

extension Clamped {
  private func clampedValue(for newValue: Value) -> Value {
    min(
      max(range.lowerBound, newValue),
      range.upperBound
    )
  }
}
