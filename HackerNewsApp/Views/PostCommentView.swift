//
//  Copyright (c) 2022 Cory Ginsberg.
//  Licensed under the Apache License, Version 2.0
//

import SwiftUI

struct PostCommentView: View {
  @ObservedObject var post: PostViewModel
  
    var body: some View {
        Text("Hello, World!")
    }
}

struct PostCommentView_Previews: PreviewProvider {
    static var previews: some View {
      PostCommentView(post: PostViewModel(itemID: 1)!)
    }
}
