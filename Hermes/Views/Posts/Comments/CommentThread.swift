//
// Copyright (c) 2023 - Present Cory Ginsberg
// Licensed under Apache License 2.0
//

//
// import AlertToast
// import SwiftUI
// import WebKit
//
// MARK: - CommentCell
//
///// Entry point for both top-level comment threads and "sub-threads" that branch off from children (ie: The comment has
///// multiple child responses on it)
/////
///// > Note: This struct runs recursively through all child comments until none are left
/////
///// > Todo: Test the performance of this and see if I can get any performance gains
/////
///// - Parameters:
/////   - commentData: The `CommentData` used to populate the comment and child comments.
/////   - indent: The indent level of the current comment. 0-based. Each reply in a thread should be one indent level
/////             higher.
/////   - hidden: Toggles the collapsed state of the comment thread.
// struct CommentThread: View {
//  @State var commentData: CommentData
//  @State var indent: Int = 0
//  @State var hidden: Bool = false
//  @State private var showingAlert = false
//  @StateObject var childCommentList: CommentListViewModel
//
//  init(commentData: CommentData, indent: Int = 0, hidden: Bool = false) {
//    self.commentData = commentData
//    self.indent = indent
//    self.hidden = hidden
//    _childCommentList = StateObject(wrappedValue: CommentListViewModel(withComments: commentData
//        .kids ?? []))
////    print(indent)
//  }
//
//  var body: some View {
//    VStack {
//      CommentBody(commentData: $commentData, showingAlert: $showingAlert, hidden: $hidden, indent: $indent)
//      if !hidden && !childCommentList.items.isEmpty {
//        ForEach(childCommentList.items) {
//          if let childComment = $0.delegate?.itemData as? CommentData {
//            CommentThread(
//              commentData: childComment,
//              indent: indent + 1
//            )
//          }
//        }
//      }
//    }
//    .contentShape(Rectangle())
//    .onTapGesture {
//      hidden.toggle()
//    }
//  }
// }
//
// #Preview("Top Level") {
//  CommentThread(commentData: TestData.Comments.randomComments[0], indent: 0)
// }
//
// #Preview("Indented") {
//  CommentThread(commentData: TestData.Comments.randomComments[0], indent: 1)
// }
