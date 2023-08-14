//
//  WebView.swift
//  Hermes
//
//  Created by Cory Ginsberg on 8/14/23.
//

import SwiftUI
import WebKit
import SafariServices

struct WebViewWrapper: UIViewControllerRepresentable {
  typealias UIViewControllerType = SFSafariViewController
  
  let url: URL
  
  func makeUIViewController(context: Context) -> SFSafariViewController {
    return SFSafariViewController(url: url)
  }
  
  func updateUIViewController(_ uiViewController: SFSafariViewController, context: Context) {
    uiViewController.loadView()
  }
}
