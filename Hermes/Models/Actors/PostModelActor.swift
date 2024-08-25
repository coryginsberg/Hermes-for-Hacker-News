//
// Copyright (c) 2023 - Present Cory Ginsberg
// Licensed under Apache License 2.0
//

import Foundation
import SwiftData

@ModelActor
actor PostModelActor {
  func insert<T>(_ model: T) throws where T: DTO {
    guard let model = model as? PostDTO else {
      throw DatabaseError.invalidModelType
    }
    let postModel = Post(fromDTO: model)
    modelContext.insert(postModel)
  }

  func insert<T>(_ models: [T]) async throws where T: DTO {
    try modelContext.transaction {
      for model in models {
        try insert(model)
      }
    }
  }

  func save() async throws {
    try modelContext.save()
  }

  func delete() async throws {
    try modelContext.delete(model: Post.self)
  }
}
