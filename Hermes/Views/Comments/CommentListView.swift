//
//  Copyright (c) 2022 Cory Ginsberg.
//  Licensed under the Apache License, Version 2.0
//

import SwiftUI

// MARK: - CommentListView

struct CommentListView: View {
  @State var postData: ItemData
  @State private var topLevelComments: [CommentInfo] = [];
  var body: some View {
    NavigationView {
      ScrollView {
        LazyVStack {
          PostCellOuterView(postData: postData, isCommentView: true)
          if let kids = postData.kids, !kids.isEmpty {
            ForEach(topLevelComments) { comment in
              CommentCell(commentData: comment.itemData, indent: 0)
            }
          } else {
            Text("Looks like there's no comments here yet");
          }
        }.task {
          topLevelComments = await TopLevelComments(self.postData).comments
        }
      }
    }
    .navigationTitle(Text(""))
    .navigationBarTitleDisplayMode(.inline)
  }
}

struct TopLevelComments: Identifiable {
  var id: ObjectIdentifier
  var comments: [CommentInfo]
  
  init(_ postData: ItemData) async {
    self.id = ObjectIdentifier.init(postData.id.customMirror.subjectType)
    self.comments = []
    if let kids = postData.kids, !kids.isEmpty {
      do {
        print(kids)
        try await kids.asyncForEach { kid in
          comments.append(try await CommentInfo(for: kid)!)
        }
      } catch {
        print(error.localizedDescription)
      }
    }
    dump(comments)
  }
}

// MARK: - PostCommentView_Previews

#Preview {
    CommentListView(postData: TestData.Posts.randomPosts[0])
}
