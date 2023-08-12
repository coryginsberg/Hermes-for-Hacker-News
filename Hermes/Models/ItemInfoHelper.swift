//
//  ItemInfoHelper.swift
//  HackerNewsApp
//
//  Created by Cory Ginsberg on 7/30/23.
//

import FaviconFinder
import Foundation

struct ItemInfoHelper {
  static func convertToDate(from timePublished: Int) -> Date {
    Date(timeIntervalSince1970: TimeInterval(timePublished))
  }

  static func loadFavicon(fromURL url: URL) async throws -> URL {
    do {
      let favicon = try await FaviconFinder(url: url, downloadImage: false).downloadFavicon()
      return favicon.url
    } catch {
      print("Error loading favicon: \(error.localizedDescription)")
      guard let url = Bundle.main.url(forResource: "awkward-monkey", withExtension: "png") else {
        throw URLError(.fileDoesNotExist)
      }
      return url
    }
  }

  static func calcTimeSince(datePosted date: Date) -> String {
    let components = Calendar(identifier: .gregorian)
      .dateComponents(
        [.minute, .hour, .day, .month, .year],
        from: date,
        to: Date()
      )
    switch components {
    case let component where component.year! > 0:
      return "\(components.year!)y"
    case let component where component.month! > 0:
      return "\(components.month!)mo"
    case let component where component.day! > 0:
      return "\(components.day!)d"
    case let component where component.hour! > 0:
      return "\(components.hour!)h"
    case let component where component.minute! > 0:
      return "\(components.minute!)m"
    default:
      return "<1m"
    }
  }
}
