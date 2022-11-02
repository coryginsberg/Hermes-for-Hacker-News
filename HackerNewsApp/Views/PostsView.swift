//
//  Copyright (c) 2022 Cory Ginsberg.
//  Licensed under the Apache License, Version 2.0
//

import Foundation
import SwiftUI

struct PostsView: View {
  let title: String = "Posts"

  @StateObject var postList = PostListViewModel()

  @Environment(\.managedObjectContext) private var viewContext

  var body: some View {
    NavigationView {
      ScrollView(.vertical) {
        LazyVStack {
          ForEach(postList.posts) { post in
            PostCellNavView(post: ItemInfo(itemID: post.itemID)!)
          }
        }
        .onAppear {
          postList.getPosts(storiesTypes: StoriesTypes.topStories)
        }
        .navigationTitle(title)
      }.refreshable {
        postList.getPosts(storiesTypes: StoriesTypes.topStories)
      }
    }
  }
}

struct PostsView_Previews: PreviewProvider {
  static var previews: some View {
    PostsView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
  }
}
