//
//  WebViewWrapper.swift
//  Hermes
//
//  Created by Cory Ginsberg on 8/14/23.
//

import SafariServices
import SwiftUI
import WebKit

struct WebViewWrapper: UIViewControllerRepresentable {
  typealias UIViewControllerType = SFSafariViewController

  let url: URL

  func makeUIViewController(context _: Context) -> SFSafariViewController {
    SFSafariViewController(url: url)
  }

  func updateUIViewController(
    _ uiViewController: SFSafariViewController,
    context _: Context
  ) {
    uiViewController.loadView()
  }
}
