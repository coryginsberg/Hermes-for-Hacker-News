//
// Copyright (c) 2024 Cory Ginsberg.
// Licensed under the Apache License, Version 2.0
//

import SwiftUI

// MARK: - CommentListView

struct CommentListView: View {
  @State var numComments: Int = 0

  @State var currentPost: PostData
  @StateObject var commentList: CommentListViewModel

  init(currentPost: PostData) {
    _currentPost = State(wrappedValue: currentPost)
    _numComments = State(wrappedValue: currentPost.descendants ?? 0)
    _commentList =
      StateObject(wrappedValue: CommentListViewModel(withComments: currentPost
          .kids ?? []))
  }

  var body: some View {
    NavigationStack {
      ScrollView(.vertical) {
        VStack {
          PostCellOuterView(postData: currentPost, isCommentView: true)
          if commentList.isLoadingPage {
            ProgressView()
          } else if commentList.items.isEmpty {
            Text("Looks like there's no comments here yet")
          } else {
            ForEach(commentList.items) { comment in
              if let commentData = comment.delegate?.itemData as? CommentData {
                CommentThread(
                  commentData: commentData
                )
                .padding(.leading, 10.0)
              }
            }
          }
        }.padding(.trailing, 16.0)
          .refreshable {
            self.numComments = currentPost.kids?.count ?? 0
            do {
              try await commentList
                .refreshCommentList(forParentComments: currentPost.kids ?? [])
            } catch {
              print("unable to refresh comment list")
            }
          }
      }
    }.navigationTitle("\(numComments) Comments")
      .navigationBarTitleDisplayMode(.inline)
  }
}

// MARK: - PostCommentView_Previews

#Preview {
  CommentListView(currentPost: TestData.Posts.randomPosts[0])
}
