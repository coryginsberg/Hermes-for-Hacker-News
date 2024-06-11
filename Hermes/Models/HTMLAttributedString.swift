//
// Copyright (c) 2023 - Present Cory Ginsberg
// Licensed under Apache License 2.0
//

import Foundation
import UIKit

enum HTMLAttributedString {
  @MainActor
  static func formatForHN(text: String) throws -> AttributedString? {
    let text = text.replacingOccurrences(of: "</p><p>", with: "<br/><br/>")
    let fontSize = UIFont.preferredFont(forTextStyle: .body).pointSize
    if let nsAttributedString = try? NSMutableAttributedString(data: text.data(using: .utf16) ?? Data(text.utf8),
                                                               options: [.documentType: NSAttributedString.DocumentType.html],
                                                               documentAttributes: nil) {
      nsAttributedString.enumerateAttributes(in: NSRange(0 ..< nsAttributedString.length)) { value, range, _ in
        if let font = value[.font] as? UIFont {
          if font.fontDescriptor.symbolicTraits.contains(.traitItalic) {
            nsAttributedString.setAttributes([.font: UIFont.italicSystemFont(ofSize: fontSize)], range: range)
          } else {
            nsAttributedString.addAttributes([.font: UIFont.preferredFont(forTextStyle: .body)], range: range)
          }
        }
      }
      // TODO: How can I have both uiKit and swiftUI here?
      let temp = try AttributedString(nsAttributedString, including: \.uiKit)
      return temp
    }
    return nil
  }
}
