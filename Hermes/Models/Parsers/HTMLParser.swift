//
// Copyright (c) 2023 - Present Cory Ginsberg
// Licensed under Apache License 2.0
//

import SwiftData
import SwiftSoup

protocol HTMLParserDelegate: AnyObject {
  associatedtype Element

  var htmlDocument: Document { get set }
  init(_ document: String) throws

  func queryAllElements(for modelContainer: ModelContainer) async throws
}

class HTMLParser {
  weak var delegate: (any HTMLParserDelegate)?
  var htmlDocument: SwiftSoup.Document

  required init(_ document: String) throws {
    do {
      htmlDocument = try SwiftSoup.parse(document)
    } catch let Exception.Error(_, message) {
      print(message)
      throw RuntimeError("Failed to parse HTML document")
    } catch {
      throw RuntimeError("Failed to parse HTML document")
    }
  }
}
