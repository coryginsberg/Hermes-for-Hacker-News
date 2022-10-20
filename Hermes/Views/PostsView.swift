//
//  Copyright (c) 2022 Cory Ginsberg.
//  Licensed under the Apache License, Version 2.0
//

import Foundation
import SwiftUI

struct PostsView: View {
  let title: String = "Posts"
<<<<<<< HEAD:Hermes/Views/PostsView.swift
=======

  @StateObject var postList = PostListViewModel()
>>>>>>> ce4e1b3 (Formatted project with swiftformat):HackerNewsApp/Views/PostsView.swift

  @Environment(\.managedObjectContext) private var viewContext

  var body: some View {
    NavigationView {
      ScrollView(.vertical) {
        LazyVStack {
          ForEach(postList.posts) { post in
            PostCell(post: PostViewModel(itemID: post.itemID)!)
          }
        }
        .onAppear {
          postList.getPosts(storiesTypes: StoriesTypes.topStories)
        }
        .onDisappear {
          postList.onViewDisappear()
        }
        .navigationTitle(title)
      }
    }
  }
}

struct PostsView_Previews: PreviewProvider {
  static var previews: some View {
    PostsView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
  }
}
