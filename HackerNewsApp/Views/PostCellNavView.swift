//
//  PostCellNavigation.swift
//  HackerNewsApp
//
//  Created by Cory Ginsberg on 10/25/22.
//

import SwiftUI

struct PostCellNavigation: View {
  @StateObject var post: PostViewModel

  let secondaryTextColor = Color(uiColor: .secondaryLabel)
  let spacer: Spacer = .init(minLength: 4.0)

  var body: some View {
    NavigationLink(destination: PostCommentView(post: post)) {
        PostCell(post: post)
    }
  }
}

struct PostCellNavigation_Previews: PreviewProvider {
  static var previews: some View {
    PostCellNavigation(post: PostViewModel(itemID: 33_244_633)!)
  }
}
