//
// Copyright (c) 2023 - Present Cory Ginsberg
// Licensed under Apache License 2.0
//

import MarkdownifyHTML
import XCTest

final class MarkdownifyHTMLTests: XCTestCase {
  let testFolder = "HTMLToTest/"
  let solutionFolder = "ExpectedResults/"
  var HTMLResultMap: Zip2Sequence<[URL], [URL]> = zip([], [])

  override func setUpWithError() throws {
    let testFilePaths = Bundle.main.urls(forResourcesWithExtension: "html", subdirectory: testFolder) ?? []
    let solutionFilePaths = Bundle.main.urls(forResourcesWithExtension: "md", subdirectory: solutionFolder) ?? []
    if testFilePaths.count != solutionFilePaths.count {
      throw TestError.testFolderNotFoundError
    }
    HTMLResultMap = zip(testFilePaths, solutionFilePaths)
  }

  func testEmptyString() {
    let expectedResult = ""
    let startingValue = ""
    let markdownify = MarkdownifyHTML.markdownify(startingValue)
    XCTAssertEqual(expectedResult, markdownify)
  }

  func testComplexStrings() {
    for (test, solution) in HTMLResultMap {
      guard let testFile = try? String(contentsOf: test, encoding: .utf16) else {
        XCTFail("Failed to load test file: \(test)")
        return
      }
      guard let solutionFile = try? String(contentsOf: solution, encoding: .utf16) else {
        XCTFail("Failed to load solution file: \(solution)")
        return
      }
      let conversion = MarkdownifyHTML.markdownify(testFile)
      if solutionFile != conversion {
        XCTFail("Expected: \(solutionFile), Actual: \(conversion)")
      }
    }
    XCTAssertTrue(true)
  }

//  func testPerformanceExample() throws {
//    // This is an example of a performance test case.
//    measure {
//      // Put the code you want to measure the time of here.
//    }
//  }
}

enum TestError: Error {
  case testFolderNotFoundError
}
