//
//  PostCommentView.swift
//  HackerNewsApp
//
//  Created by Cory Ginsberg on 10/16/22.
//

import SwiftUI

struct PostCommentView: View {
  @ObservedObject var post: PostViewModel
  
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

struct PostCommentView_Previews: PreviewProvider {
    static var previews: some View {
      PostCommentView(post: PostViewModel(itemID: 1)!)
    }
}
