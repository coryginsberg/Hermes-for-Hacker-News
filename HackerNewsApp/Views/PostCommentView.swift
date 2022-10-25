//
//  Copyright (c) 2022 Cory Ginsberg.
//  Licensed under the Apache License, Version 2.0
//

import SwiftUI

struct PostCommentView: View {
  @ObservedObject var post: PostViewModel

  var body: some View {
    NavigationView {

      ScrollView {
        PostCell(post: post)
        ForEach(post.itemData?.kids ?? [], id: \.self) { comment in
          Text("\(comment)")
        }
      }
    }
    .navigationTitle(Text(""))
    .navigationBarTitleDisplayMode(.inline)
  }
}

// struct Comment: View {
//   var body: some View {
//
//   }
// }

struct PostCommentView_Previews: PreviewProvider {
  static var previews: some View {
    PostCommentView(post: PostViewModel(itemID: 1)!)
  }
}
