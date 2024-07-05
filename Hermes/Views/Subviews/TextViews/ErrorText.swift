//
// Copyright (c) 2023 - Present Cory Ginsberg
// Licensed under Apache License 2.0
//

import SwiftUI

enum ErrorType {
  case network
  case loading
  case unknown
}

struct ErrorText: View {
  @State var errorType: ErrorType
  @State var error: Error

  init(_ error: Error, errorType: ErrorType = .unknown) {
    self.error = error
    self.errorType = errorType
  }

  var body: some View {
    if errorType == .network {
      return Text("Network Error: \(error.localizedDescription)")
        .onAppear {
          LogError(error)
        }
        .previewLayout(.sizeThatFits)
    } else if errorType == .loading {
      return Text("Loading Error: \(error.localizedDescription)")
        .onAppear {
          LogError(error)
        }
        .previewLayout(.sizeThatFits)
    } else {
      return Text("Unknown Error: \(error.localizedDescription)")
        .onAppear {
          LogError(error)
        }
        .previewLayout(.sizeThatFits)
    }
  }
}

extension ErrorText: Logging {}

// #Preview {
//  ErrorText()
// }
