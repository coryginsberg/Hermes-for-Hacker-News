//
//  Copyright (c) 2022 Cory Ginsberg.
//  Licensed under the Apache License, Version 2.0
//

import SwiftUI

struct PostCell: View {
  @StateObject var post: PostViewModel
  
  let primaryTextColor = Color(uiColor: .label)
  let secondaryTextColor = Color(uiColor: .secondaryLabel)
  let spacer = Spacer(minLength: 4.0)
  
  var body: some View {
    NavigationLink(destination: PostCommentView(post: post)) {
      VStack(alignment: .leading) {
        HStack {
          Image("AwkwardMonkey")
            .resizable()
            .frame(width: 50.0, height: 50.0)
            .cornerRadius(8.0)
            .padding(20.0)
          VStack(alignment: .leading) {
            Text(post.postData?.title ?? "")
              .font(.headline)
              .foregroundColor(primaryTextColor)
              .multilineTextAlignment(.leading)
            Spacer().frame(height: 10)
            HStack {
              Image(systemName: "arrow.up")
                .dynamicTypeSize(.small)
                .foregroundColor(secondaryTextColor)
              Text("\(post.postData?.score ?? 0)")
                .foregroundColor(secondaryTextColor)
              spacer
              Image(systemName: "bubble.left")
                .dynamicTypeSize(.small)
                .foregroundColor(secondaryTextColor)
              Text("\(post.postData?.descendants ?? 0)")
                .foregroundColor(secondaryTextColor)
              spacer
              Image(systemName: "clock")
                .dynamicTypeSize(.small)
                .foregroundColor(secondaryTextColor)
              Text("9h")
                .foregroundColor(secondaryTextColor)
              spacer
            }
          }
        }.fixedSize(horizontal: false, vertical: true)
        GeometryReader { geometry in
          Divider().frame(width: abs(geometry.size.width - 32)).padding(.horizontal, 16.0)
        }
      }
    }
  }
}

struct PostCell_Previews: PreviewProvider {
  static var previews: some View {
    PostCell(post: PostViewModel(itemID: 1)!)
  }
}
