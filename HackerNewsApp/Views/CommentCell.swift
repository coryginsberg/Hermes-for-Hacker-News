//
//  Copyright (c) 2022 Cory Ginsberg.
//  Licensed under the Apache License, Version 2.0
//

import SwiftUI

struct CommentCell: View {
  @StateObject var comment: ItemInfo
  
  var body: some View {
    if let commentData = comment.itemData {
      let primaryColor = commentData.dead ? Color(uiColor: .systemGray5) : Color(uiColor: .label)
      let secondaryColor = commentData.dead ? Color(uiColor: .systemGray5) : Color(uiColor: .secondaryLabel)

      VStack() {
        Text(commentData.text.markdownToAttributed())
          .foregroundColor(primaryColor)
          .multilineTextAlignment(.leading)
          .padding(.bottom, 6.0)
          .allowsTightening(true)
          .frame(maxWidth: .infinity, alignment: .leading)
        HStack() {
          Image(systemName: "clock")
            .dynamicTypeSize(.xSmall)
            .foregroundColor(secondaryColor)
          SecondaryText(textBody: commentData.time, textColor: secondaryColor)
          if (commentData.score != 0) {
            SecondaryImage(imageName: "arrow.up", textColor: secondaryColor)
            SecondaryText(textBody: "\(commentData.score)", textColor: secondaryColor)
          }
          Text("– \(commentData.author)")
            .allowsTightening(true)
            .frame(maxWidth: .infinity, alignment: .trailing)
            .font(.system(size: 14))
            .foregroundColor(secondaryColor)
            .lineLimit(1)
          if (commentData.dead) {
            Text("[dead]").allowsTightening(true)
              .font(.system(size: 14))
              .foregroundColor(secondaryColor)
          }
        }
        GeometryReader { geometry in
          Divider()
            .frame(width: abs(geometry.size.width))
        }
      }.padding(.horizontal, 16.0)
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

struct CommentCell_Preview: PreviewProvider {
  static var previews: some View {
    CommentCell(comment: ItemInfo(itemID: 33430726)!)
  }
}
