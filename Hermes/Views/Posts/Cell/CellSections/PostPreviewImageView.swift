//
//  PostPreviewImageView.swift
//  Hermes
//
//  Created by Cory Ginsberg on 8/14/23.
//

import SwiftUI

struct PostPreviewImageView: View {
  @State var url: URL
  @State var faviconUrl: URL
  @State private var showSafari: Bool = false

  var body: some View {
    AsyncImage(url: faviconUrl) { phase in
      switch phase {
      case .empty:
        ProgressView()
      case let .success(image):
        image
          .resizable()
          .scaledToFit()
          .transition(.scale(scale: 0.1, anchor: .center))
      case .failure:
        Image("AwkwardMonkey")
          .resizable()
          .scaledToFit()
          .transition(.scale(scale: 0.1, anchor: .center))
      @unknown default:
        EmptyView()
      }
    }
    .frame(width: 50, height: 50, alignment: .top)
    .clipShape(RoundedRectangle(cornerRadius: 8))
    .padding(.leading, 24)
    .onTapGesture {
      showSafari.toggle()
    }
    .fullScreenCover(isPresented: $showSafari, content: {
      WebViewWrapper(url: url)
    })
  }
}

#Preview {
  PostCellOuterView(postData: TestData.Posts.randomPosts[0])
}
