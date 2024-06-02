//
// Copyright (c) 2023 - Present Cory Ginsberg
// Licensed under Apache License 2.0
//

import AlertToast
import SwiftUI
import WebKit

// MARK: - CommentCell

/// Entry point for both top-level comment threads and "sub-threads" that branch off from children (ie: The comment has
/// multiple child responses on it)
///
/// > Note: This struct runs recursively through all child comments until none are left
///
/// > Todo: Test the performance of this and see if I can get any performance gains
///
/// - Parameters:
///   - commentData: The `CommentData` used to populate the comment and child comments.
///   - indent: The indent level of the current comment. 0-based. Each reply in a thread should be one indent level
///             higher.
///   - hidden: Toggles the collapsed state of the comment thread.
struct CommentThread: View {
  @State var comment: Comment
  @State private var showingAlert = false
  @State private var hidden = false

  var body: some View {
    LazyVStack {
      CommentCell(commentData: $comment,
                  showingAlert: $showingAlert,
                  isHidden: $hidden)
      if !$comment.children.isEmpty {
        // Recursively loop through until we run out of children
        ForEach(comment.children) { child in
          CommentThread(
            comment: child
          )
        }.padding(.leading, 16.0)
          .if(hidden) { view in
            view.frame(height: 0)
          }
          .opacity(hidden ? 0 : 1)
          .animation(.easeInOut, value: hidden)
      }
    }
    .contentShape(Rectangle())
    .onTapGesture {
      hidden.toggle()
    }
  }
}

#Preview {
  CommentListView(isPreview: true, selectedPost: Binding.constant(.preview))
}
