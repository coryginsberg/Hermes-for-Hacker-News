//
// Copyright (c) 2023 - Present Cory Ginsberg
// Licensed under Apache License 2.0
//

import Foundation

extension Post {
  static var preview: Post {
    return Post(postId: 40500071,
                tags: [],
                author: "realslimginz",
                children: nil,
                createdAt: Date(),
                numComments: 15,
                points: 19,
                title: "Lorem Ipsum Dolor Sit Amet Consectetur Adipiscing Elit",
                updatedAt: Date(),
                url: "https://www.example.com/",
                text: nil,
                index: 0)
  }
}
