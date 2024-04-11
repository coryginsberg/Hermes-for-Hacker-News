////
////  CommentBody.swift
////  Hermes
////
////  Created by Cory Ginsberg on 3/10/24.
////
//
// import AlertToast
// import SwiftUI
//
// struct CommentBody: View {
//  @Binding var commentData: CommentData
//  @Binding var showingAlert: Bool
//  @Binding var hidden: Bool
//  @Binding var indent: Int
//
//  var body: some View {
//    VStack {
//      if !hidden {
//        CommentText(commentData: $commentData)
//      }
//      SecondaryCommentInfoGroup(
//        commentData: commentData,
//        showingAlert: $showingAlert
//      )
//      Divider()
//    }.indent($indent)
//  }
// }
//
//// MARK: - Comment Text
//
// private struct CommentText: View {
//  @Binding var commentData: CommentData
//
////  @EnvironmentObject var viewModel: AlertViewModal
//
//  private let pasteboard = UIPasteboard.general
//
//  func copyToClipboard(commentText: String) {
//    viewModel.alertToast = AlertToast(
//      displayMode: .hud,
//      type: .complete(.green),
//      title: "Text copied"
//    )
//    DispatchQueue.main.asyncAfter(deadline: .now() + 1.5, qos: .utility) {
//      pasteboard.string = commentText
//      viewModel.show.toggle()
//    }
//  }
//
//  var body: some View {
//    let prefixText = commentData.dead ? "[dead] " : commentData
//      .deleted ? "[deleted] " : ""
//
//    if let commentText = try? AttributedString(
//      markdown: "\(prefixText)\(commentData.text ?? "")"
//    ) {
//      Text(commentText)
//        .commentStyle(isDead: commentData.dead)
//        .contextMenu {
//          Button {
//            copyToClipboard(commentText: String(commentText
//                .characters[...]))
//          } label: {
//            Label("Copy", systemImage: "doc.on.doc")
//          }
//          Button {} label: {
//            Label("Share", systemImage: "square.and.arrow.up")
//          }
//        }
//    }
//  }
// }
