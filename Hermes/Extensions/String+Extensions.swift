//
// Copyright (c) 2024 Cory Ginsberg.
// Licensed under the Apache License, Version 2.0
//

import Foundation
import RegexBuilder

private let characterEntities: [Substring: Character] = [
  // XML predefined entities:
  "&quot;": "\"",
  "&amp;": "&",
  "&apos;": "'",
  "&lt;": "<",
  "&gt;": ">",

  // HTML character entity references:
  "&nbsp;": "\u{00a0}",
  // ...
  "&diams;": "♦",
]

/// Hacker News comment text is encoded as HTML before being added to the JSON
/// blob.
/// The extension below allows us to decode the HTML then convert that to
/// Markdown
/// which the `Text()` SwiftUI struct has limited support for.
extension String {
  // MARK: - String to HTML

  /// Returns a new string made by replacing in the `String` all HTML character
  /// entity
  /// references with the corresponding character.
  var stringByDecodingHTMLEntities: String {
    // ===== Utility functions =====

    // Convert the number in the string to the corresponding Unicode character,
    // e.g.
    //    decodeNumeric("64", 10)   --> "@"
    //    decodeNumeric("20ac", 16) --> "€"
    func decodeNumeric(_ string: Substring, base: Int) -> Character? {
      guard let code = UInt32(string, radix: base),
            let uniScalar = UnicodeScalar(code) else { return nil }
      return Character(uniScalar)
    }

    // Decode the HTML character entity to the corresponding Unicode character,
    // return
    // `nil` for invalid input.
    //     decode("&#64;")    --> "@"
    //     decode("&#x20ac;") --> "€"
    //     decode("&lt;")     --> "<"
    //     decode("&foo;")    --> nil
    func decode(_ entity: Substring) -> Character? {
      if entity.hasPrefix("&#x") || entity.hasPrefix("&#X") {
        return decodeNumeric(entity.dropFirst(3).dropLast(), base: 16)
      } else if entity.hasPrefix("&#") {
        return decodeNumeric(entity.dropFirst(2).dropLast(), base: 10)
      } else {
        return characterEntities[entity]
      }
    }

    var result = ""
    var position = startIndex

    // Find the next '&' and copy the characters preceding it to `result`:
    while let ampRange = self[position...].range(of: "&") {
      result.append(contentsOf: self[position ..< ampRange.lowerBound])
      position = ampRange.lowerBound

      // Find the next ';' and copy everything from '&' to ';' into `entity`
      guard let semiRange = self[position...].range(of: ";") else {
        // No matching ';'.
        break
      }
      let entity = self[position ..< semiRange.upperBound]
      position = semiRange.upperBound

      if let decoded = decode(entity) {
        // Replace by decoded character:
        result.append(decoded)
      } else {
        // Invalid entity, copy verbatim:
        result.append(contentsOf: entity)
      }
    }
    // Copy remaining characters to `result`:
    result.append(contentsOf: self[position...])
    return result
  }

  // MARK: - HTML To Markdown

  func htmlToMarkDown() -> String {
    // Replace line feeds with nothing, which is how HTML notation is read in
    // the
    // browsers
    var text = replacing("\n", with: "")

    // Line breaks
    text = text.replacing("<div>", with: "\n\n")
    text = text.replacing("</div>", with: "")
    text = text.replacing("<p>", with: "\n\n")
    text = text.replacing("<br>", with: "\n\n")

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
        // A hyperlink that is embedded in an HTML tag in this format: <a...
        // href="<hyperlink>"....>
        "<a"
        // There could be other attributes between <a... and href=... .reluctant
        // parameter:
        // to stop matching after the first occurrence
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
        // After href="<hyperlink>", there could be a ">" sign or other
        // attributes
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
        let markDownLink = "[\(content)](\(href))"
        text = text.replacing(hyperlinkTag, with: markDownLink)
      } else {
        loop = false
      }
    }
    return text
  }
}
