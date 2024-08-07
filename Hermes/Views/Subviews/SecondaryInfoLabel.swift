//
// Copyright (c) 2023 - Present Cory Ginsberg
// Licensed under Apache License 2.0
//

import SwiftUI

struct SecondaryCommentInfoGroup: View {
  let comment: Comment
  @Binding var isHidden: Bool
  @Binding var showingAlert: Bool

  var body: some View {
    HStack {
      Text("– \(comment.author)").secondaryStyle()
      HStack {
        if !isHidden {
          SecondaryInfoButton(systemImage: "arrowshape.turn.up.left") { showingAlert = true }
        } else {
          SecondaryCommentCount(numComments: comment.countDescendants())
        }
        SecondaryInfoLabel(
          systemImage: "clock",
          textBody: DateFormatter.calcTimeSince(datePosted: comment.createdAt)
        )
        if let points = comment.points, points > 0 {
          SecondaryInfoLabel(
            systemImage: "arrow.up",
            textBody: "\(points)"
          )
        }
        if !isHidden {
          SecondaryInfoButton(systemImage: "ellipsis") { showingAlert = true }
        } else {
          SecondaryInfoButton(systemImage: "chevron.down") { isHidden = false }
        }
      }.padding(.leading, 6.0)
    }
  }
}

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

struct SecondaryCommentCount: View {
  var numComments: Int = 1

  var body: some View {
    Image("\(numComments.clamped(to: 1 ... 20)).bubble.filled")
      .font(.callout)
      .foregroundStyle(.tertiary)
      .padding(.horizontal, 3)
      .padding(.top, 1)
  }
}
