//
// Copyright (c) 2023 - Present Cory Ginsberg
// Licensed under Apache License 2.0
//

import SwiftUI

struct WebView: View {
  @State var url: URL

  var body: some View {
    WebViewWrapper(url: url)
  }
}
