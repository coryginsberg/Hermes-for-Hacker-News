//
// Copyright (c) 2023 - Present Cory Ginsberg
// Licensed under Apache License 2.0
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
