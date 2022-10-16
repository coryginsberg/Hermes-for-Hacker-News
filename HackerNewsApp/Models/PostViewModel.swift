//
//  Copyright (c) 2022 Cory Ginsberg.
//  Licensed under the Apache License, Version 2.0
//

import FirebaseDatabase

class PostViewModel: ObservableObject, Identifiable {
  private let ref = Database.root
  
  @Published var itemID: Int
  
  init?(itemID: Int) {
    self.itemID = itemID
  }
}
