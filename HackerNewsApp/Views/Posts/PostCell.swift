//
//  Copyright (c) 2022 Cory Ginsberg.
//  Licensed under the Apache License, Version 2.0
//

import SwiftUI

struct PostCell: View {
  @State var postData: ItemData

  let secondaryTextColor = Color(uiColor: .secondaryLabel)
  let spacer: Spacer = .init(minLength: 4.0)

  var body: some View {
    VStack(alignment: .leading) {
      Grid(alignment: .leading) {
        GridRow {
          if postData.type == "story" {
            AsyncImage(url: postData.faviconUrl) { image in
                   image.resizable()
              } placeholder: {
                Image("AwkwardMonkey")
              }
              .frame(width: 50, height: 50, alignment: .top)
              .clipShape(RoundedRectangle(cornerRadius: 8)).padding(.leading, 24)
          }
          VStack(alignment: .leading) {
            PrimaryLabelView(postData: postData, secondaryTextColor: secondaryTextColor)
            SecondaryLabelsView(postData: postData, textColor: secondaryTextColor)
          }.padding(.horizontal, 16.0)
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

struct PrimaryLabelView: View {
  var postData: ItemData?
  var secondaryTextColor: Color
      
  var body: some View {
    Text(postData?.title ?? "")
      .foregroundColor(Color(uiColor: .label))
      .multilineTextAlignment(.leading)
      .padding(.bottom, 6.0)
      .allowsTightening(true)
      .frame(maxWidth: .infinity, alignment: .leading)
//    SecondaryText(textBody: (URL(string: (postData?.url)!)?.baseURL!.absoluteString)!, textColor: secondaryTextColor)

  }
}

struct SecondaryLabelsView: View {
  var postData: ItemData?
  var textColor: Color

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
    PostCell(postData: TestData.postsData[0])
  }
}
