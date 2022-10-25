//
//  CommentModel.swift
//  HackerNewsApp
//
//  Created by Cory Ginsberg on 10/25/22.
//

import FirebaseDatabase
import Foundation

class CommentModel: ObservableObject, Identifiable {
  private let ref = Database.root
  var itemIDs: [Int]

  @Published var commentText: String?

  init?(itemIDs: [Int]) {
    self.itemIDs = itemIDs
    commentText = nil
  }

  func getCommentInfo() {

  }

}
