//
//  Copyright (c) 2022 Cory Ginsberg.
//  Licensed under the Apache License, Version 2.0
//

import SwiftUI

struct PostCommentView: View {
  @ObservedObject var post: ItemInfo

  var body: some View {
    NavigationView {
      ScrollView {
        LazyVStack {
          PostCell(post: post)
          ForEach(post.itemData?.kids ?? [], id: \.self) { comment in
            let _ = print(comment)
            CommentCell(comment: ItemInfo(itemID: comment)!)
          }
        }
        
      }
    }
    .navigationTitle(Text(""))
    .navigationBarTitleDisplayMode(.inline)
  }
}

struct PostCommentView_Previews: PreviewProvider {
  static var previews: some View {
    PostCommentView(post: ItemInfo(itemID: 1)!)
  }
}
