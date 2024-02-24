//
// Copyright (c) 2024 Cory Ginsberg.
// Licensed under the Apache License, Version 2.0
//

import Foundation
import SwiftUI

// MARK: - PostListView

struct PostListView: View {
  let title: String = "Posts"

  @StateObject var postList = PostListViewModel(forStoryType: .topStories)

  @Environment(\.managedObjectContext) private var viewContext

  var body: some View {
    NavigationStack {
      ScrollView(.vertical) {
        LazyVStack {
          ForEach(postList.items) { post in
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
          do {
            try await postList.refreshPostList()
          } catch {
            print("unable to refresh post list")
          }
        }
      }
    }
//    NavigationView {
//      ScrollView(.vertical) {
//
//      }
//    }
  }
}

// MARK: - PostsListView_Previews

struct PostsListView_Previews: PreviewProvider {
  static var previews: some View {
    PostListView()
  }
}
