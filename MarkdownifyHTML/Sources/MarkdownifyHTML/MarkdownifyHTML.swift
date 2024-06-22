// The Swift Programming Language
// https://docs.swift.org/swift-book

import CxxStdlib
import html2md

public enum MarkdownifyHTML {
  public static func markdownify(_ html: String) -> String {
    var temp = std.string(html)
    var options = html2md.Options.self.init()
    var converter = html2md.Converter(&temp, withUnsafeMutablePointer(to: &options) { optionsPtr in
      optionsPtr
    })
    return String(converter.convert())
  }
}
