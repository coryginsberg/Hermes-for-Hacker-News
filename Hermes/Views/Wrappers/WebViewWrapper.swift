//
// Copyright (c) 2024 Cory Ginsberg.
// Licensed under the Apache License, Version 2.0
//

import SafariServices
import SwiftUI
import WebKit

struct WebViewWrapper: UIViewControllerRepresentable {
  typealias UIViewControllerType = SFSafariViewController

  let url: URL

  func makeUIViewController(context _: Context) -> SFSafariViewController {
    return SFSafariViewController(url: url)
  }

  func updateUIViewController(
    _ uiViewController: SFSafariViewController,
    context _: Context
  ) {
    uiViewController.loadView()
  }
}
