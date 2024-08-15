//
// Copyright (c) 2023 - Present Cory Ginsberg
// Licensed under Apache License 2.0
//

import Foundation

struct ListSort: Codable, Identifiable {
  var icon: String
  var text: String
  var param: String
  var id: String {
    text.lowercased()
  }
}

enum SortOption: Codable, Identifiable, Equatable {
  var id: String {
    rawValue.id
  }

  case news // Homepage
  case newest
  case best
  case ask
  case show
  case jobs
  case front(Date) // `/front` is structured `/front?day=2024-08-05`. Defaults
  // to yesterday.

  var rawValue: ListSort {
    switch self {
    case .news: return .init(icon: "newspaper", text: "Default", param: "news")
    case .newest: return .init(
        icon: "newspaper",
        text: "Newest",
        param: "newest"
      )
    case .best: return .init(icon: "star", text: "Best", param: "best")
    case .ask: return .init(icon: "question-mark", text: "Ask", param: "ask")
    case .show: return .init(icon: "tv", text: "Show", param: "show")
    case .jobs: return .init(icon: "briefcase", text: "Jobs", param: "jobs")
    case let .front(date):
      return .init(
        icon: "calendar",
        text: "Front",
        param: "front?day=\(date.formatted(date: .short))"
      )
    }
  }
}

extension SortOption: CaseIterable {
  static var allCases: [SortOption] {
    return [.news, .newest, .best, .ask, .show, .jobs, .front(Date())]
  }
}

private extension Date {
  func formatted(date _: DateFormatter.Style = .short) -> String {
    let formatter = DateFormatter()
    formatter.dateFormat = "yyyy-MM-dd"
    formatter.timeStyle = .none

    return formatter.string(from: self)
  }
}
