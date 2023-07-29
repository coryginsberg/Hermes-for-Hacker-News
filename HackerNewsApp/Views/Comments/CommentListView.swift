//
//  Copyright (c) 2022 Cory Ginsberg.
//  Licensed under the Apache License, Version 2.0
//

import SwiftUI

struct CommentListView: View {
  @State var postData: ItemData

  var body: some View {
    NavigationView {
      ScrollView {
        LazyVStack {
          PostCell(postData: postData)
//          ForEach(postData.kids ?? [], id: \.self) { comment in
//            CommentCell(commentData: ItemInfo(itemID: comment))
//          }
        }
      }
    }
    .navigationTitle(Text(""))
    .navigationBarTitleDisplayMode(.inline)
  }
}

struct PostCommentView_Previews: PreviewProvider {
  static var previews: some View {
    CommentListView(postData: TestData.postsData[0])
  }
}
