//
// Copyright (c) 2024 Cory Ginsberg.
// Licensed under the Apache License, Version 2.0
//

import SwiftUI

// struct SecondaryCommentInfoGroup: View {
//  let commentData: CommentData
//  @Binding var showingAlert: Bool
//
//  var body: some View {
//    HStack {
//      Text("– \(commentData.author)").secondaryStyle(isDead: commentData.dead)
//
//      Group {
//        SecondaryInfoButton(
//          systemImage: "arrowshape.turn.up.left",
//          textBody: ""
//        ) { showingAlert = true }
//        SecondaryInfoLabel(
//          systemImage: "clock",
//          textBody: ItemInfoHelper
//            .calcTimeSince(datePosted: commentData.time)
//        )
//        if commentData.score > 0 {
//          SecondaryInfoLabel(
//            systemImage: "arrow.up",
//            textBody: "\(commentData.score)"
//          )
//        }
//        SecondaryInfoButton(
//          systemImage: "ellipsis",
//          textBody: ""
//        ) { showingAlert = true }
//      }.padding(.leading, 6.0)
//    }
//  }
// }

struct SecondaryInfoLabel: View {
  let systemImage: String
  let textBody: String

  var body: some View {
    HStack {
      SecondaryImage(systemImage: systemImage)
      SecondaryText(textBody: textBody)
    }
  }
}

struct SecondaryInfoButton: View {
  let systemImage: String
  let textBody: String
  let action: () -> Void

  var body: some View {
    Button("", systemImage: systemImage, action: action)
      .buttonStyle(SecondaryInfoButtonStyle())
  }
}

struct SecondaryInfoButtonStyle: ButtonStyle {
  func makeBody(configuration: ButtonStyleConfiguration) -> some View {
    configuration.label
      .scaleEffect(configuration.isPressed ? 0.7 : 1)
      .animation(
        .easeOut(duration: 0.2),
        value: configuration.isPressed
      )
      .foregroundStyle(.secondary)
      .font(.caption)
      .padding(.bottom, 6)
  }
}

// MARK: - SecondaryImage

struct SecondaryImage: View {
  let systemImage: String

  var body: some View {
    Image(systemName: systemImage)
      .font(.caption)
      .foregroundStyle(.secondary)
      .padding(.horizontal, -4)
  }
}

// MARK: - SecondaryText

struct SecondaryText: View {
  var textBody: String

  var body: some View {
    Text(textBody)
      .foregroundStyle(.secondary)
      .font(.system(size: 12))
      .lineLimit(1)
  }
}
