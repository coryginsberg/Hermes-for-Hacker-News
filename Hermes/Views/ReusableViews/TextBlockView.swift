//
// Copyright (c) 2023 - Present Cory Ginsberg
// Licensed under Apache License 2.0
//

import MarkdownifyHTML
import SwiftUI

struct TextBlockView: View {
  @State var text: String
  @State var styledText: AttributedString?

  var body: some View {
    Group {
      if let styledText {
        Text(styledText)
      } else {
        // fallback
        // TODO: Add logging for why `styledText` failed
        Text(text)
      }
    }.onAppear {
      let markdown = MarkdownifyHTML(text,
                                     withMarkdownOptions: .init(interpretedSyntax: .inlineOnly))
      styledText = try? markdown.attributedText
    }
  }
}

#Preview {
  ModelContainerPreview(PreviewSampleData.inMemoryContainer, addPadding: true) {
    TextBlockView(text: Post.formattedText.text ?? "")
  }
}
