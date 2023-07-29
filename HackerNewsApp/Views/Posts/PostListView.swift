//
//  Copyright (c) 2022 Cory Ginsberg.
//  Licensed under the Apache License, Version 2.0
//

import Foundation
import SwiftUI

struct PostListView: View {
  let title: String = "Posts"
<<<<<<< HEAD:Hermes/Views/PostsView.swift
=======

  @StateObject var postList = PostListViewModel()
<<<<<<< HEAD:Hermes/Views/PostsView.swift
>>>>>>> ce4e1b3 (Formatted project with swiftformat):HackerNewsApp/Views/PostsView.swift
=======
>>>>>>> 998347e (.):HackerNewsApp/Views/PostsView.swift

  @Environment(\.managedObjectContext) private var viewContext

  var body: some View {
    NavigationView {
      ScrollView(.vertical) {
        LazyVStack {
          ForEach(postList.posts) { post in
            PostCellNavView(postData: post.itemData ?? TestData.postsData[0])
          }
        }
<<<<<<< HEAD:Hermes/Views/PostsView.swift
        .onAppear {
          postList.getPosts(storiesTypes: StoriesTypes.topStories)
        }
        .onDisappear {
          postList.onViewDisappear()
        }
        .navigationTitle(title)
=======
        .task {
          await postList.genPosts(storiesTypes: StoriesTypes.topStories)
        }
        .navigationTitle(title)
      }.refreshable {
        await postList.genPosts(storiesTypes: StoriesTypes.topStories)
>>>>>>> 27f66b4 (Added Favicon support):HackerNewsApp/Views/Posts/PostsView.swift
      }
    }
  }
}

struct PostsView_Previews: PreviewProvider {
  static var previews: some View {
    PostListView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
  }
}
