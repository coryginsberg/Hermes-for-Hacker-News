//
//  Copyright (c) 2022 Cory Ginsberg.
//  Licensed under the Apache License, Version 2.0
//

import SwiftUI

struct PostCell: View {
  @StateObject var post: PostViewModel

  let secondaryTextColor = Color(uiColor: .secondaryLabel)
  let spacer: Spacer = .init(minLength: 4.0)

  var body: some View {
<<<<<<< HEAD
    NavigationLink(destination: PostCommentView(post: post)) {
      VStack(alignment: .leading) {
<<<<<<< HEAD
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
=======
        Grid(alignment: .leading) {
          GridRow {
            if post.postData?.type == "story" {
              Image("AwkwardMonkey")
                .resizable()
                .frame(width: 50.0, height: 50.0)
                .cornerRadius(8.0)
                .padding(.leading, 24.0)
            }
            VStack(alignment: .leading) {
              PrimaryLabelView(text: post.postData?.title ?? "Lorem Ipsum")
              SecondaryLabelsView(textColor: secondaryTextColor, postData: post.postData)
            }.padding(.horizontal, 16.0)
          }
          GeometryReader { geometry in
            Divider()
              .frame(width: abs(geometry.size.width - 32))
              .padding(.horizontal, 16.0)
>>>>>>> 3ab97c2 (Nits, formatted code, and added author to post preview)
          }
        }.fixedSize(horizontal: false, vertical: true)
      }
=======
    VStack(alignment: .leading) {
      Grid(alignment: .leading) {
        GridRow {
          if post.itemData?.type == "story" {
            Image("AwkwardMonkey")
              .resizable()
              .frame(width: 50.0, height: 50.0)
              .cornerRadius(8.0)
              .padding(.leading, 24.0)
          }
          VStack(alignment: .leading) {
            PrimaryLabelView(text: post.itemData?.title ?? "")
            SecondaryLabelsView(textColor: secondaryTextColor, postData: post.itemData)
          }.padding(.horizontal, 16.0)
        }
        GeometryReader { geometry in
          Divider()
            .frame(width: abs(geometry.size.width - 32))
            .padding(.horizontal, 16.0)
        }
      }.fixedSize(horizontal: false, vertical: true)
>>>>>>> 39507b4 (Changed "PostData" to "ItemData" and added extra items)
    }
  }
}

<<<<<<< HEAD
<<<<<<< HEAD
<<<<<<< HEAD
struct PostCell_Previews: PreviewProvider {
  static var previews: some View {
    PostCell(post: PostViewModel(itemID: 1)!)
=======
=======
=======
>>>>>>> e5414dc (Nits, formatted code, and added author to post preview)
struct PrimaryLabelView: View {
  var text: String

  var body: some View {
    Text(text)
      .foregroundColor(Color(uiColor: .label))
      .multilineTextAlignment(.leading)
      .padding(.bottom, 6.0)
      .allowsTightening(true)
      .frame(maxWidth: .infinity, alignment: .leading)
  }
}

<<<<<<< HEAD
>>>>>>> 3ab97c2 (Nits, formatted code, and added author to post preview)
=======
>>>>>>> e5414dc (Nits, formatted code, and added author to post preview)
struct SecondaryLabelsView: View {
  var textColor: Color
  var postData: ItemData?

  var body: some View {
    ViewThatFits(in: .horizontal) {
      HStack(spacing: 4.0) {
        SecondaryImage(imageName: "arrow.up", textColor: textColor)
        SecondaryText(textBody: "\(postData?.score ?? 0)", textColor: textColor)
        SecondaryImage(imageName: "bubble.left", textColor: textColor)
        SecondaryText(textBody: "\(postData?.descendants ?? 0)", textColor: textColor)
        Image(systemName: "clock")
          .dynamicTypeSize(.xSmall)
          .foregroundColor(textColor)
        SecondaryText(textBody: postData?.time ?? "", textColor: textColor)
        Text("by \(postData?.author ?? "")")
          .allowsTightening(true)
          .frame(maxWidth: .infinity, alignment: .trailing)
          .font(.system(size: 14))
          .foregroundColor(textColor)
          .lineLimit(1)
      }
    }
  }
}

struct SecondaryImage: View {
  let imageName: String
  let textColor: Color

  var body: some View {
    Image(systemName: imageName)
      .dynamicTypeSize(.xSmall)
      .foregroundColor(textColor)
  }
}

struct SecondaryText: View {
  var textBody: String
  var textColor: Color

  var body: some View {
    Text(textBody)
      .foregroundColor(textColor)
      .font(.system(size: 12))
      .padding(.trailing, 6.0)
      .lineLimit(1)

  }
}

struct PostCell_Previews: PreviewProvider {
  static var previews: some View {
    PostCell(post: PostViewModel(itemID: 33_244_633)!)
>>>>>>> 92b9663 (Formatted project with swiftformat)
  }
}
