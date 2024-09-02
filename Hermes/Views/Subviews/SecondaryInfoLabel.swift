//
// Copyright (c) 2023 - Present Cory Ginsberg
// Licensed under Apache License 2.0
//

import SwiftUI

// struct SecondaryCommentInfoGroup: View {
//  let comment: Comment
//  @Binding var isHidden: Bool
//  @Binding var showingAlert: Bool
//
//  var body: some View {
//    HStack {
//      Text("– \(comment.author)").secondaryStyle()
//      HStack {
//        if !isHidden {
//          SecondaryInfoButton(systemImage: "arrowshape.turn.up.left") { showingAlert = true }
//        } else {
//          SecondaryCommentCount(numComments: comment.countDescendants())
//        }
//        SecondaryInfoLabel(
//          systemImage: "clock",
//          textBody: DateFormatter.calcTimeSince(datePosted: comment.createdAt)
//        )
//        if let points = comment.points, points > 0 {
//          SecondaryInfoLabel(
//            systemImage: "arrow.up",
//            textBody: "\(points)"
//          )
//        }
//        if !isHidden {
//          SecondaryInfoButton(systemImage: "ellipsis") { showingAlert = true }
//        } else {
//          SecondaryInfoButton(systemImage: "chevron.down") { isHidden = false }
//        }
//      }.padding(.leading, 6.0)
//    }
//  }
// }

struct SecondaryInfoButton: View {
  let systemImage: String
  let textBody: String
  let action: () -> Void

  var body: some View {
    Button { action() } label: {
      HStack {
        Image(systemName: systemImage)
          .secondaryInfoFormat()
          .padding(.horizontal, -4)
        Text(textBody).secondaryInfoFormat()
      }
    }.buttonStyle(SecondaryInfoButtonStyle())
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

struct AuthorText: View {
  var author: Author

  var body: some View {
    Text("by \(author.username)")
      .allowsTightening(true)
      .frame(maxWidth: .infinity, alignment: .trailing)
      .secondaryInfoFormat(withTextColor: getTextColor())
  }

  func getTextColor() -> Color {
    if let postColor = author.color {
      return Color(postColor)
    }
    return .secondary
  }
}

// MARK: - Secondary Info Format

private struct SecondaryInfoFormat: ViewModifier {
  var textColor: Color = .secondary

  func body(content: Content) -> some View {
    content
      .foregroundStyle(.secondary)
      .font(.caption)
      .lineLimit(1)
  }
}

public extension View {
  @ViewBuilder
  func secondaryInfoFormat(withTextColor textColor: Color = .secondary) -> some View {
    modifier(SecondaryInfoFormat(textColor: textColor))
  }
}
