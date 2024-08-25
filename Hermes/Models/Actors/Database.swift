//
// Copyright (c) 2023 - Present Cory Ginsberg
// Licensed under Apache License 2.0
//

import Foundation
import SwiftData

protocol HermesEnvironment: Sendable {
  func insert<T>(_ model: T) async throws where T: DTO

  func save() async throws
  func fetch<T>(_ descriptor: FetchDescriptor<T>) async throws -> [T] where T: PersistentModel

  func delete<T: PersistentModel>(
    where predicate: Predicate<T>?
  ) async throws
}

extension HermesEnvironment {
  func fetch<T: PersistentModel>(
    where predicate: Predicate<T>?,
    sortBy: [SortDescriptor<T>]
  ) async throws -> [T] {
    try await self.fetch(FetchDescriptor<T>(predicate: predicate, sortBy: sortBy))
  }

  func fetch<T: PersistentModel>(
    _ predicate: Predicate<T>,
    sortBy: [SortDescriptor<T>] = []
  ) async throws -> [T] {
    try await self.fetch(where: predicate, sortBy: sortBy)
  }

  func fetch<T: PersistentModel>(
    _: T.Type,
    predicate: Predicate<T>? = nil,
    sortBy: [SortDescriptor<T>] = []
  ) async throws -> [T] {
    try await self.fetch(where: predicate, sortBy: sortBy)
  }

  func delete<T: PersistentModel>(
    model _: T.Type,
    where predicate: Predicate<T>? = nil
  ) async throws {
    try await self.delete(where: predicate)
  }

  func insert<T>(_ models: [T]) async throws where T: DTO {
    for model in models {
      try await self.insert(model)
    }
  }
}

enum DatabaseError: Error {
  case invalidModelType
}
