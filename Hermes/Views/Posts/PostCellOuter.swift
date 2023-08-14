//
//  PostCellNavigation.swift
//  HackerNewsApp
//
//  Created by Cory Ginsberg on 10/25/22.
//

import SwiftUI

// MARK: - PostCellOuter

struct PostCellOuter: View {
  @State var postData: ItemData
  @State private var showSafari: Bool = false

  let secondaryTextColor = Color(uiColor: .secondaryLabel)
  let spacer = Spacer(minLength: 4.0)

  var body: some View {
    VStack(alignment: .leading) {
      Grid(alignment: .leading) {
        GridRow {
          if postData.type == .story, let url = postData.url, let faviconURL = postData.faviconUrl {
            NavigationLink(destination: WebViewWrapper(url: url)) {
              PostPreviewImage(faviconURL: faviconURL)
                .onTapGesture {
                  showSafari.toggle()
                }
            }
            .fullScreenCover(isPresented: $showSafari, content: {
              WebViewWrapper(url: url)
            })
          }
          NavigationLink(destination: CommentListView(postData: postData)) {
            PostCellText(postData: postData)
          }
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
  PostCellOuter(postData: TestData.Posts.randomPosts[0])
}
