//
// Copyright (c) 2023 - Present Cory Ginsberg
// Licensed under Apache License 2.0
//

import MarkdownifyHTML

// import Markdownosaur
import SwiftUI

struct TextBlockView: View {
  @State var text: String
  var styledText: AttributedString {
    guard let attributedString = try? MarkdownifyHTML(
      text,
      withMarkdownOptions: .init(allowsExtendedAttributes: true, interpretedSyntax: .inlineOnlyPreservingWhitespace)
    ).attributedText else {
      return AttributedString(MarkdownifyHTML(text).text)
    }
    return attributedString
  }

  var body: some View {
    Text(styledText)
      .lineLimit(nil)
      .multilineTextAlignment(.leading)
  }
}

#Preview {
  ModelContainerPreview(PreviewSampleData.inMemoryContainer, addPadding: true) {
    TextBlockView(text: Post.formattedText.text ?? "")
  }
}
