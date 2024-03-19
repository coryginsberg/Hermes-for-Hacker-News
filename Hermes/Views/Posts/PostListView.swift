//
// Copyright (c) 2024 Cory Ginsberg.
// Licensed under the Apache License, Version 2.0
//

import Foundation
import SwiftUI

// MARK: - PostListView

struct PostListView: View {
  let title: String = "Posts"
  @State var postType: StoriesTypes

  @StateObject private var postList: PostListViewModel

  @Environment(\.managedObjectContext) private var viewContext

  init(postType: StoriesTypes = .topStories) {
    self.postType = postType
    _postList = StateObject(wrappedValue: .init(forStoryType: postType))
  }

  var body: some View {
    NavigationStack {
      LazyVStack {
        switch postList.status {
        case .loading:
          ProgressView()
        case .loaded:
          PostListLoadedView()
        case .noStoryTypeError:
          Text("Tried to generate a story without defining the story type")
        case .error(let error):
          Text("Error: \(error.localizedDescription)")
        }
      }
      .navigationTitle(self.title)
    }.task {
      postList.setStoryType(self.postType)
      await postList.genQueryInitialPosts()
    }.environmentObject(postList)
  }
}

struct PostListLoadedView: View {
  @EnvironmentObject private var postList: PostListViewModel

  var body: some View {
    let posts = postList.items.enumerated().map { $0 }
    List(posts, id: \.element.id) { index, post in
      if let postData = post.delegate?.itemData as? PostData {
        PostCellOuterView(postData: postData)
          .task {
            do {
              try await postList.genRequestMoreItemsIfNeeded(index: index)
            } catch {
              print("Here")
            }
          }
      }
    }.refreshable {
      await postList.genRefreshPostList()
    }.onAppear {
      print("Post List Appeared")
    }.listStyle(PlainListStyle())
      .frame(height: UIScreen.main.bounds.height - 120)
  }
}

// MARK: - PostsListView_Previews

struct PostsListView_Previews: PreviewProvider {
  static var previews: some View {
    PostListView(postType: .bestStories)
  }
}
