//
//  PostCellNavigation.swift
//  HackerNewsApp
//
//  Created by Cory Ginsberg on 10/25/22.
//

import SwiftUI

// MARK: - PostCellOuter

struct PostCellOuterView: View {
  @State var postData: ItemData

  let secondaryTextColor = Color(uiColor: .secondaryLabel)
  let spacer = Spacer(minLength: 4.0)

  var body: some View {
    VStack(alignment: .leading) {
      Grid(alignment: .leading) {
        GridRow {
          if postData.type == .story, let url = postData.url, let faviconUrl = postData.faviconUrl {
            PostPreviewImageView(url: url, faviconUrl: faviconUrl)
          }
          PostCellTextView(postData: postData)
        }
        GeometryReader { geometry in
          Divider()
            .frame(width: abs(geometry.size.width - 32))
            .padding(.horizontal, 16.0)
        }
      }.fixedSize(horizontal: false, vertical: true)
    }
  }
}

#Preview {
  PostCellOuterView(postData: TestData.Posts.randomPosts[0])
}
