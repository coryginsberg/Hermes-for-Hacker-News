//
//  PostPreviewImage.swift
//  Hermes
//
//  Created by Cory Ginsberg on 8/14/23.
//

import SwiftUI

struct PostPreviewImage: View {
  @State var faviconURL: URL

  var body: some View {
    AsyncImage(url: faviconURL) { phase in
      switch phase {
      case .empty:
        ProgressView()
      case let .success(image):
        image
          .resizable()
          .scaledToFit()
          .transition(.scale(scale: 0.1, anchor: .center))
      case .failure:
        Image(systemName: "wifi.slash")
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
  }
}

#Preview {
  PostPreviewImage(faviconURL: TestData.Posts.randomPosts[0].url!)
}
