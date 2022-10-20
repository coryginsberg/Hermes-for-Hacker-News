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
        Grid(alignment: .leading) {
          GridRow {
            Image("AwkwardMonkey")
              .resizable()
              .frame(width: 50.0, height: 50.0)
              .cornerRadius(8.0)
              .padding(.leading, 24.0)
              .padding(.trailing, 16.0)
            VStack {
              Text(post.postData?.title ?? "Linus Torvalds to kernel devs: Grow up and stop pulling all-nighters")
                .foregroundColor(primaryTextColor)
                .alignmentGuide(.leading) { _ in 0 }
                .multilineTextAlignment(.leading)
                .padding(.trailing, 16.0)
                .padding(.bottom, 6.0)
                .allowsTightening(true)
              SecondaryLabelsView(textColor: secondaryTextColor, postData: post.postData)
            }.padding(.trailing, 16.0)
          }
          GeometryReader { geometry in
            Divider()
              .frame(width: abs(geometry.size.width - 32))
              .padding(.horizontal, 16.0)
          }
        }
      }
    }
  }
}

struct SecondaryLabelsView: View {
  var textColor: Color
  var postData: PostData?
  
  var body: some View {
    ViewThatFits(in: .horizontal) {
      HStack {
        Spacer()
        Image(systemName: "arrow.up")
          .dynamicTypeSize(.small)
          .foregroundColor(textColor)
        Text("\(postData?.score ?? 0)")
          .foregroundColor(textColor)
        Spacer()
        Image(systemName: "bubble.left")
          .dynamicTypeSize(.small)
          .foregroundColor(textColor)
        Text("\(postData?.descendants ?? 0)")
          .foregroundColor(textColor)
        Spacer()
        Image(systemName: "clock")
          .dynamicTypeSize(.small)
          .foregroundColor(textColor)
        Text("9h")
          .foregroundColor(textColor)
        Spacer()
      }
    }
  }
}

struct PostCell_Previews: PreviewProvider {
  static var previews: some View {
    PostCell(post: PostViewModel(itemID: 33244633)!)
  }
}
