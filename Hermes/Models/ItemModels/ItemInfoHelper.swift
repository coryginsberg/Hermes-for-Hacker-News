//
// Copyright (c) 2024 Cory Ginsberg.
// Licensed under the Apache License, Version 2.0
//

import FaviconFinder
import Foundation

enum ItemInfoHelper {
  static func convertToDate(from timePublished: Int) -> Date {
    Date(timeIntervalSince1970: TimeInterval(timePublished))
  }

  static func calcTimeSince(datePosted date: Date) -> String {
    let components = Calendar(identifier: .gregorian)
      .dateComponents(
        [.minute, .hour, .day, .month, .year],
        from: date,
        to: Date()
      )
    switch components {
    case let component where (component.year ?? 0) > 0:
      return "\(components.year ?? 0)y"
    case let component where (component.month ?? 0) > 0:
      return "\(components.month ?? 0)mo"
    case let component where (component.day ?? 0) > 0:
      return "\(components.day ?? 0)d"
    case let component where (component.hour ?? 0) > 0:
      return "\(components.hour ?? 0)h"
    case let component where (component.minute ?? 0) > 0:
      return "\(components.minute ?? 0)m"
    default:
      return "<1m"
    }
  }
}
