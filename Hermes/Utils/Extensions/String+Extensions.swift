//
// Copyright (c) 2023 - Present Cory Ginsberg
// Licensed under Apache License 2.0
//

import Foundation

// MARK: - Get the first number found

extension String {
  var firstNumber: Int? {
    guard let numInStr = components(separatedBy: .decimalDigits.inverted).first else { return 0 }
    return Int(numInStr)
  }
}
