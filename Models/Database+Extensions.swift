//
//  Copyright (c) 2022 Cory Ginsberg.
//
//  Licensed under the Apache License, Version 2.0
//

import FirebaseDatabase

extension Database {
  class var root: DatabaseReference {
    return database().reference()
  }
}
