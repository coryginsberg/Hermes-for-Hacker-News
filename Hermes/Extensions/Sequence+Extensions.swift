//
//  Sequence+Extensions.swift
//  HackerNewsApp
//
//  Created by Cory Ginsberg on 7/27/23.
//

import Foundation

extension Sequence {
  func asyncCompactMap<T>(
    _ transform: (Element) async throws -> T?
  ) async rethrows -> [T] {
    var values = [T]()

    for element in self {
      guard try await transform(element) != nil else { continue }
      try await values.append(transform(element)!)
    }

    return values
  }

  func concurrentCompactMap<T>(
    _ transform: @escaping (Element) async throws -> T?
  ) async throws -> [T] {
    let tasks = map { element in
      Task {
        try await transform(element)
      }
    }

    return try await tasks.asyncCompactMap { task in
      try await task.value
    }
  }
}
