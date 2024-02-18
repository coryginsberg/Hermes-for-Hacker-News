//
//  Copyright (c) 2022 Cory Ginsberg.
//  Licensed under the Apache License, Version 2.0
//

import SwiftUI
import WebKit

// MARK: - CommentCell

struct CommentCell: View {
  @State var commentData: ItemData
  @State var indent: Int8

  //  @StateObject var commentList = CommentViewModel()

  var body: some View {
    let primaryColor = commentData
      .dead ? Color(uiColor: .systemGray5) : Color(uiColor: .label)
    let secondaryColor = commentData
      .dead ? Color(uiColor: .systemGray5) : Color(uiColor: .secondaryLabel)
    let prefixText = commentData.dead ? "[dead] " : commentData
      .deleted ? "[deleted] " : ""

    VStack {
      VStack {
        Text("\(prefixText)\(commentData.text ?? "")")
          .foregroundColor(primaryColor)
          .multilineTextAlignment(.leading)
          .padding(.bottom, 6.0)
          .allowsTightening(true)
          .frame(maxWidth: .infinity, alignment: .leading)
          .dynamicTypeSize(.medium)

        HStack {
          Image(systemName: "clock")
            .dynamicTypeSize(.xSmall)
            .foregroundColor(secondaryColor)
          SecondaryText(
            textBody: ItemInfoHelper
              .calcTimeSince(datePosted: commentData.time),
            textColor: secondaryColor
          )
          if commentData.score != 0 {
            SecondaryImage(imageName: "arrow.up", textColor: secondaryColor)
            SecondaryText(
              textBody: "\(commentData.score)",
              textColor: secondaryColor
            )
          }
          Text("– \(commentData.author)")
            .allowsTightening(true)
            .frame(maxWidth: .infinity, alignment: .trailing)
            .font(.system(size: 14))
            .foregroundColor(secondaryColor)
            .lineLimit(1)
        }
        GeometryReader { geometry in
          Divider()
            .frame(width: abs(geometry.size.width))
        }
      }.padding(.horizontal, 16.0)
      ForEach(Array(commentData.kids ?? []), id: \.self) { _ in

        //        CommentCell(commentData: child.delegate.itemData, indent: 1
        //          Task {
        //            let commentInfo = await CommentInfo(for: child)
        //            await CommentCell(commentData: commentInfo!.itemData,
        //            indent: indent + 1)
        //          }
        //        }
      }
    }
  }
}

extension String {
  func markdownToAttributed() -> AttributedString {
    do {
      return try AttributedString(markdown: self)
    } catch {
      return AttributedString("Error parsing markdown: \(error)")
    }
  }
}
