//
// Copyright (c) 2023 - Present Cory Ginsberg
// Licensed under Apache License 2.0
//

import MarkdownifyHTML
import SwiftUI

struct TextBlockView: View {
  @State var text: String

  var styledText: AttributedString {
//    var text = self.text
//    // wrap the first paragraph in a <p></p> if it's not already and there's other paragraphs in the string
//    if let index = text.range(of: "<p>")?.lowerBound {
//      text.insert(contentsOf: "</p>", at: index)
//      text.insert(contentsOf: "<p>", at: text.startIndex)
//    }
    do {
      let attributedString = try MarkdownifyHTML(
        text,
        withMarkdownOptions: .init(allowsExtendedAttributes: true, interpretedSyntax: .inlineOnlyPreservingWhitespace)
      ).attributedText
      return attributedString
    } catch {
      print(error)
      return AttributedString()
    }
  }

  var body: some View {
//    Group {
    Text(styledText).onAppear {
//      print(styledText)
    }
//    }
  }
}

#Preview {
  ModelContainerPreview(PreviewSampleData.inMemoryContainer) {
    TextBlockView(text: Post.formattedText.text ?? "")
  }
}
