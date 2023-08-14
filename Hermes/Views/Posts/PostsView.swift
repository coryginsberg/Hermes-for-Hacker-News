//
//  Copyright (c) 2022 Cory Ginsberg.
//  Licensed under the Apache License, Version 2.0
//

import Foundation
import SwiftUI

// MARK: - PostsView

struct PostsView: View {
  let title: String = "Posts"

  @StateObject var postList = PostListViewModel()

  @Environment(\.managedObjectContext) private var viewContext

  var body: some View {
    NavigationView {
      ScrollView(.vertical) {
        LazyVStack {}
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

// MARK: - PostsView_Previews

struct PostsView_Previews: PreviewProvider {
  static var previews: some View {
    PostsView()
  }
}
