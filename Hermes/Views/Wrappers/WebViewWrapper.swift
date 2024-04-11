//
<<<<<<< HEAD
//  WebViewWrapper.swift
//  Hermes
//
//  Created by Cory Ginsberg on 8/14/23.
=======
// Copyright (c) 2024 Cory Ginsberg.
// Licensed under the Apache License, Version 2.0
>>>>>>> mvc-rewrite
//

import SafariServices
import SwiftUI
import WebKit

struct WebViewWrapper: UIViewControllerRepresentable {
  typealias UIViewControllerType = SFSafariViewController

  let url: URL

  func makeUIViewController(context _: Context) -> SFSafariViewController {
<<<<<<< HEAD
    SFSafariViewController(url: url)
=======
    return SFSafariViewController(url: url)
>>>>>>> mvc-rewrite
  }

  func updateUIViewController(
    _ uiViewController: SFSafariViewController,
    context _: Context
  ) {
    uiViewController.loadView()
  }
}
