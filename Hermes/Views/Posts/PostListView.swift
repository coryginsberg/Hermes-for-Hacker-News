//
//  Copyright (c) 2022 Cory Ginsberg.
//  Licensed under the Apache License, Version 2.0
//

import Foundation
import SwiftUI

// MARK: - PostListView

struct PostListView: View {
  let title: String = "Posts"

  @StateObject var postList = PostListViewModel(forStoryType: .topStories)

  @Environment(\.managedObjectContext) private var viewContext

  var body: some View {
    NavigationView {
      ScrollView(.vertical) {
        LazyVStack {
          ForEach(postList.posts) { post in
            PostCellOuterView(postData: post.delegate.itemData)
              .onAppear {
                Task {
                  await postList.loadMoreContentIfNeeded(currentItem: post)
                }
              }
          }
          if postList.isLoadingPage {
            ProgressView()
          }
        }
        .navigationTitle(title)
        .refreshable {
          await postList.refreshPostList()
        }
      }
    }
  }
}

// MARK: - PostsListView_Previews

struct PostsListView_Previews: PreviewProvider {
  static var previews: some View {
    PostListView()
  }
}
