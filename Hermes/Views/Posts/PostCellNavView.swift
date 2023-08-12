//
//  PostCellNavigation.swift
//  HackerNewsApp
//
//  Created by Cory Ginsberg on 10/25/22.
//

import SwiftUI

// MARK: - PostCellNavView

struct PostCellNavView: View {
  @State var postData: ItemData

  let secondaryTextColor = Color(uiColor: .secondaryLabel)
  let spacer: Spacer = .init(minLength: 4.0)

  var body: some View {
    NavigationLink(destination: CommentListView(postData: postData)) {
      PostCell(postData: postData)
    }
  }
}

// MARK: - PostCellNavView_Previews

struct PostCellNavView_Previews: PreviewProvider {
  static var previews: some View {
    PostCellNavView(postData: TestData.Posts.randomPosts[0])
  }
}
