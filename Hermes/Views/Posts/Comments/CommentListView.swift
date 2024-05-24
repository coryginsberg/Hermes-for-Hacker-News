//
// Copyright (c) 2023 - Present Cory Ginsberg
// Licensed under Apache License 2.0
//

import SwiftData
import SwiftUI

// MARK: - CommentListView

struct CommentListView: View {
  @Environment(\.modelContext) private var modelContext
  @Query var postWithComments: [PostWithComments]

  @Binding var selectedPostID: PersistentIdentifier?
  private var selectedPost: Post?

  init(selectedPostID: Binding<PersistentIdentifier?>, selectedPost: Post?) {
    _selectedPostID = selectedPostID
    self.selectedPost = selectedPost
  }

  var body: some View {
    NavigationStack {
      if selectedPostID == nil {
        Text("Nothing selected")
      } else if selectedPost?.numComments == 0 {
        Text("No comments... yet...")
      } else if postWithComments.isEmpty || postWithComments[0].children.count < selectedPost?.numComments ?? 0 {
        ProgressView()
      } else {
        Text(postWithComments[0].children[0].text)
      }

//      ScrollView(.vertical) {
//        VStack {
//          PostCellOuterView(postData: currentPost, isCommentView: true)
//          if commentList.isLoadingPage {
//            ProgressView()
//          } else if commentList.items.isEmpty {
//            Text("Looks like there's no comments here yet")
//          } else {
//            ForEach(commentList.items) { comment in
//              if let commentData = comment.delegate?.itemData as? CommentData {
//                CommentThread(
//                  commentData: commentData
//                )
//                .padding(.leading, 10.0)
//              }
//            }
//          }
//        }.padding(.trailing, 16.0)
//          .refreshable {
//            self.numComments = currentPost.kids?.count ?? 0
//            do {
//              try await commentList
//                .refreshCommentList(forParentComments: currentPost.kids ?? [])
//            } catch {
//              print("unable to refresh comment list")
//            }
//          }
//      }
//    }.navigationTitle("\(numComments) Comments")
//      .navigationBarTitleDisplayMode(.inline)
    }.onChange(of: selectedPostID, initial: true) {
      Task {
//        if let selectedPost = self.selectedPost {
        ////          let post = modelContext.registeredModel(for: selectedPostID)
        ////          self.postWithComments = try await PostWithComments(from: post.itemId)
        await AngoliaItem.loadItem(fromId: selectedPost?.itemId ?? 0, modelContext: modelContext)
//        }
      }
//      Task {
//        // TODO: This is only loading the first item over and over again???
//        for comment in post.children {
//          print(comment)
//          await AngoliaItem.loadItem(fromId: comment, modelContext: modelContext)
//        }
//      }
    }
  }
}
