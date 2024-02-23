//
//  Copyright (c) 2022 Cory Ginsberg.
//  Licensed under the Apache License, Version 2.0
//

import SwiftUI
import WebKit
import RegexBuilder

// MARK: - CommentCell

struct CommentCell: View {
  @State var commentData: ItemData
  @State var indent: Int
  @StateObject var childCommentList: CommentListViewModel

  var childComments: [ItemData] = []
  
  init(commentData: ItemData, indent: Int) {
    _commentData = State(wrappedValue: commentData);
    _indent = State(wrappedValue: indent);
    
    _childCommentList = StateObject(wrappedValue: CommentListViewModel(withComments: commentData.kids ?? []))
  }

  var body: some View {
    let primaryColor = commentData.dead ? Color(uiColor: .systemGray5) : Color(uiColor: .label)
    let secondaryColor =
      commentData.dead ? Color(uiColor: .systemGray5) : Color(uiColor: .secondaryLabel)
    let prefixText = commentData.dead ? "[dead] " : commentData.deleted ? "[deleted] " : ""

    LazyVStack {
      Text("\(prefixText)\(commentData.text?.htmlToMarkDown() ?? "")")
        .foregroundColor(primaryColor)
        .multilineTextAlignment(.leading)
        .padding(.bottom, 6.0)
        .allowsTightening(true)
        .frame(maxWidth: .infinity, alignment: .topLeading)
        .dynamicTypeSize(.medium)

      HStack {
        Image(systemName: "clock")
          .dynamicTypeSize(.xSmall)
          .foregroundColor(secondaryColor)
        SecondaryText(
          textBody: ItemInfoHelper.calcTimeSince(datePosted: commentData.time),
          textColor: secondaryColor
        )
        if commentData.score != 0 {
          SecondaryImage(imageName: "arrow.up", textColor: secondaryColor)
          SecondaryText(textBody: "\(commentData.score)", textColor: secondaryColor)
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
      if !childCommentList.items.isEmpty {
        ForEach(childCommentList.items, content: { kid in
          CommentCell(commentData: kid.delegate.itemData, indent: indent + 1)
        })
      }
    }.padding(.leading, 16.0)
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

extension String {
    func htmlToMarkDown() -> String {
        // Replace line feeds with nothing, which is how HTML notation is read in the browsers
        var text = self.replacing("\n", with: "")
        
        // Line breaks
        text = text.replacing("<div>", with: "\n")
        text = text.replacing("</div>", with: "")
        text = text.replacing("<p>", with: "\n")
        text = text.replacing("<br>", with: "\n")

        // Text formatting
        text = text.replacing("<strong>", with: "**")
        text = text.replacing("</strong>", with: "**")
        text = text.replacing("<b>", with: "**")
        text = text.replacing("</b>", with: "**")
        text = text.replacing("<em>", with: "*")
        text = text.replacing("</em>", with: "*")
        text = text.replacing("<i>", with: "*")
        text = text.replacing("</i>", with: "*")
        
        // Replace hyperlinks block
        var loop = true
        // Stop looking for hyperlinks when none is found
        while loop {
            // Retrieve hyperlink
            let searchHyperlink = Regex {
                // A hyperlink that is embedded in an HTML tag in this format: <a... href="<hyperlink>"....>
                "<a"
                // There could be other attributes between <a... and href=...
                // .reluctant parameter: to stop matching after the first occurrence
                ZeroOrMore(.any)
                // We could have href="..., href ="..., href= "..., href = "...
                "href"
                ZeroOrMore(.any)
                "="
                ZeroOrMore(.any)
                "\""
                // Here is where the hyperlink (href) is captured
                Capture {
                    ZeroOrMore(.any)
                }
                "\""
                // After href="<hyperlink>", there could be a ">" sign or other attributes
                ZeroOrMore(.any)
                ">"
                // Here is where the linked text is captured
                Capture {
                    ZeroOrMore(.any, .reluctant)
                }
                One("</a>")
            }
                .repetitionBehavior(.reluctant)
            
            if let match = text.firstMatch(of: searchHyperlink) {
                let (hyperlinkTag, href, content) = match.output
                let markDownLink = "[" + content + "](" + href + ")"
                text = text.replacing(hyperlinkTag, with: markDownLink)
            } else {
                loop = false
            }
        }
        return text
    }
}


#Preview {
  CommentCell(commentData: TestData.Comments.randomComments[0], indent: 0)
}
