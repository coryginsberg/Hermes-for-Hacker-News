//
//  Copyright (c) 2022 Cory Ginsberg.
//
//  Licensed under the Apache License, Version 2.0
//

import Foundation
import SwiftUI

struct PostsView: View {
//  @StateObject var postList = PostListViewModel()
//  @StateObject var user = UserViewModel()

  // define variables for creating a new post for iOS
  #if os(iOS) || os(tvOS)
    @State private var newPostsViewPresented = false
  #endif

  var title: String
//  var postsType: PostsType

  var body: some View {
    NavigationView {
      Text("hello world")
//      List {
//        ForEach(postList.posts) { post in
//
//          PostCell(post: post)
//        }
//      }
//      .onAppear {
////        postList.getPosts(postsType: postsType)
//      }
//      .onDisappear {
////        postList.onViewDisappear()
//      }
        .navigationTitle(title)
      .toolbar {
        ToolbarItemGroup(placement: .navigationBarTrailing) {
          Button(action: {
            newPostsViewPresented = true
          }) {
            Image(systemName: "plus")
          }
//          .sheet(isPresented: $newPostsViewPresented) {
//            NewPostsView(postList: postList, isPresented: $newPostsViewPresented)
//          }
        }
      }
    }
  }
}

struct PostsView_Previews: PreviewProvider {
  static var previews: some View {
    PostsView(title: "Posts")
  }
}

