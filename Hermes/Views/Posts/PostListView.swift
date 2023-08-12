//
//  Copyright (c) 2022 Cory Ginsberg.
//  Licensed under the Apache License, Version 2.0
//

import Foundation
import SwiftUI

struct PostListView: View {
  let title: String = "Posts"

  @StateObject var postList = PostListViewModel()

  @Environment(\.managedObjectContext) private var viewContext

  var body: some View {
    NavigationView {
      ScrollView(.vertical) {
        LazyVStack {
          ForEach(postList.posts) { post in
            PostCellNavView(postData: post.delegate.itemData)
          }
        }
        .task {
          await postList.genPosts(storiesTypes: StoriesTypes.topStories)
        }
        .navigationTitle(title)
      }.refreshable {
        await postList.genPosts(storiesTypes: StoriesTypes.topStories)
      }
    }
  }
}

struct PostsListView_Previews: PreviewProvider {
  static var previews: some View {
    PostListView()
  }
}
