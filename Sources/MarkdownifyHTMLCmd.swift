// The Swift Programming Language
// https://docs.swift.org/swift-book
//
// Swift Argument Parser
// https://swiftpackageindex.com/apple/swift-argument-parser/documentation

import ArgumentParser

@main
struct MarkdownifyHTMLCmd: ParsableCommand {
  @Argument(help: "The file to load")
  var file: String

  mutating func run() throws {

  }
}
