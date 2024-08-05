//
// Copyright (c) 2023 - Present Cory Ginsberg
// Licensed under Apache License 2.0
//

import MarkdownifyHTML
import SafariServices
import SwiftUI

struct TextBlockView: View {
  @State var text: String

  var styledText: AttributedString {
    do {
      let attributedString = try MarkdownifyHTML(
        text,
        withMarkdownOptions: .init(allowsExtendedAttributes: true, interpretedSyntax: .inlineOnlyPreservingWhitespace)
      ).attributedText
      return attributedString
    } catch {
      print(error)
      return AttributedString()
    }
  }

  var body: some View {
    Text(styledText).onOpenURL(handler: { url in
      let vc = SFSafariViewController(url: url)
      UIApplication.shared.firstKeyWindow?.rootViewController?.present(vc, animated: true)
      return .handled
    })
  }
}

extension View {
  func onOpenURL(handler: @escaping (_ url: URL) -> OpenURLAction.Result) -> some View {
    return environment(\.openURL, OpenURLAction(handler: handler))
  }
}

extension UIApplication {
  var firstKeyWindow: UIWindow? {
    return UIApplication.shared.connectedScenes
      .compactMap { $0 as? UIWindowScene }
      .filter { $0.activationState == .foregroundActive }
      .first?.keyWindow
  }
}

// #Preview(traits: .sizeThatFitsLayout) {
//  ModelContainerPreview(PreviewSampleData.inMemoryContainer) {
//    TextBlockView(text: Post.formattedText.text ?? "").environment(PostView.NavigationModel(testPost: Post.link))
//  }
// }
