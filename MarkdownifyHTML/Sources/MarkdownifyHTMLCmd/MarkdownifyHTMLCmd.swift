// The Swift Programming Language
// https://docs.swift.org/swift-book
//
// Swift Argument Parser
// https://swiftpackageindex.com/apple/swift-argument-parser/documentation

import ArgumentParser
import Foundation
import MarkdownifyHTML

@available(macOS 10.15.4, *)
@main
struct MarkdownifyHTMLCmd: ParsableCommand {
  @Argument(
    help: "File to be parsed.",
    transform: URL.init(fileURLWithPath:)
  )
  var file: URL

  mutating func run() throws {
//    let handle = try FileHandle(forReadingFrom: file)
//    guard let data = try? handle.readToEnd() else {
//      throw RuntimeError("Couldn't read from '\(file)'!")
//    }
    guard let input = try? String(contentsOf: file) else {
      throw RuntimeError("Couldn't read from '\(file)'!")
    }

    let markdownify = MarkdownifyHTML.markdownify(input)
    print(markdownify)
  }
}

struct RuntimeError: Error, CustomStringConvertible {
  var description: String

  init(_ description: String) {
    self.description = description
  }
}
