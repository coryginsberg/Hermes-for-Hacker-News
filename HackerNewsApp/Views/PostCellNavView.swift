//
//  PostCellNavigation.swift
//  HackerNewsApp
//
//  Created by Cory Ginsberg on 10/25/22.
//

import SwiftUI

struct PostCellNavView: View {
  @StateObject var post: PostViewModel

  let secondaryTextColor = Color(uiColor: .secondaryLabel)
  let spacer: Spacer = .init(minLength: 4.0)

  var body: some View {
    NavigationLink(destination: PostCommentView(post: post)) {
        PostCell(post: post)
    }
  }
}

struct PostCellNavView_Previews: PreviewProvider {
  static var previews: some View {
    PostCellNavView(post: PostViewModel(itemID: 33_244_633)!)
  }
}
