//
//  Copyright (c) 2022 Cory Ginsberg.
//  Licensed under the Apache License, Version 2.0
//

import SwiftUI
import WebKit

struct CommentCell: View {
  @State var commentData: ItemData

  var body: some View {
//  let primaryColor = commentData.dead ? Color(uiColor: .systemGray5) : Color(uiColor: .label)
    let secondaryColor = commentData.dead ? Color(uiColor: .systemGray5) : Color(uiColor: .secondaryLabel)
    let prefixText = commentData.dead ? "[dead]" : commentData.deleted ? "[deleted]" : ""

    VStack {
      Text("\(prefixText) \(commentData.text.markdownToAttributed())")
//          .foregroundColor(primaryColor)
//          .multilineTextAlignment(.leading)
//          .padding(.bottom, 6.0)
//          .allowsTightening(true)
//          .frame(maxWidth: .infinity, alignment: .leading)
//          .dynamicTypeSize(.medium)

      HStack {
        Image(systemName: "clock")
          .dynamicTypeSize(.xSmall)
          .foregroundColor(secondaryColor)
        SecondaryText(textBody: commentData.time, textColor: secondaryColor)
        if commentData.score != 0 {
          SecondaryImage(imageName: "arrow.up", textColor: secondaryColor)
          SecondaryText(textBody: "\(commentData.score)", textColor: secondaryColor)
        }
        Text("– \(commentData.author)")
          .allowsTightening(true)
          .frame(maxWidth: .infinity, alignment: .trailing)
          .font(.system(size: 14))
          .foregroundColor(secondaryColor)
          .lineLimit(1)
      }
      GeometryReader { geometry in
        Divider()
          .frame(width: abs(geometry.size.width))
      }
    }.padding(.horizontal, 16.0)
  }
}

extension String {
  func markdownToAttributed() -> AttributedString {
    do {
      return try AttributedString(markdown: self)
    } catch {
      return AttributedString("Error parsing markdown: \(error)")
    }
  }
}

// struct WebViewWrapper: UIViewControllerRepresentable {
//  typealias UIViewControllerType = .
//
//  let html: String
////  var intrinsicContentSize: CGSize { textContainer.frame.size + (mainViewPadding * 2) }
//
//  func makeUIView(context: Context) -> WKWebView {
//    return WKWebView()
//  }
//
//  func updateUIView(_ uiView: WKWebView, context: Context) {
//    uiView.loadHTMLString(html, baseURL: nil)
//  }
//
//  func webViewDidFinishLoad(_ webView: WKWebView) {
//      var frame = webView.frame
//      frame.size.height = 1
//      webView.frame = frame
//      let fittingSize = webView.sizeThatFits(CGSize.init(width: 0, height: 0))
//      frame.size = fittingSize
//      webView.frame = frame
//  }
//
//
////  func sizeThatFits(_ proposal: ProposedViewSize, uiView: WKWebView, context: Context) -> CGSize? {
////    return CGSize(width: proposal.width!, height: ))
////  }
// }
