//
//  PostPrimaryLabelView.swift
//  Hermes
//
//  Created by Cory Ginsberg on 8/14/23.
//

import SwiftUI
import DomainParser

struct PostPrimaryLabelView: View {
  var postData: ItemData
  var secondaryTextColor: Color
  
  var body: some View {
    NavigationLink(destination: CommentListView(postData: postData)) {
      VStack(alignment: .leading) {
        Text(postData.title ?? "")
          .foregroundColor(Color(uiColor: .label))
          .multilineTextAlignment(.leading)
          .allowsTightening(true)
          .frame(maxWidth: .infinity, alignment: .leading)
        if let url = postData.url {
          Text(url.domain ?? "")
              .font(.footnote)
              .frame(maxWidth: .infinity, alignment: .topLeading)
              .padding(.bottom, 4.0)
              .foregroundColor(.init(uiColor: .tertiaryLabel))
        }
      }
    }
  }
}

#Preview {
  PostCellOuterView(postData: TestData.Posts.randomPosts[0])
}
