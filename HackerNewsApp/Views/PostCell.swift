//
//  Copyright (c) 2022 Cory Ginsberg.
//  Licensed under the Apache License, Version 2.0
//

import SwiftUI

struct PostCell: View {
  @StateObject var post: PostViewModel

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
            Text("Lorem Ipsum").font(.headline)
            HStack {
              Image(systemName: "arrow.up")
                .dynamicTypeSize(.small)
              Text("11.6k")
              Spacer(minLength: 4.0)
              Image(systemName: "bubble.left")
                .dynamicTypeSize(.small)
              Text("107")
              Spacer(minLength: 4.0)
              Image(systemName: "clock")
                .dynamicTypeSize(.small)
              Text("9h")
              Spacer(minLength: 4.0)
            }
          }
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
