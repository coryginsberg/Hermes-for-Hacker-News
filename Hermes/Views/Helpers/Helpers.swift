//
//  Helpers.swift
//  Hermes
//
//  Created by Cory Ginsberg on 4/10/24.
//

import Foundation

extension DateFormatter {
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
