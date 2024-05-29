//
// Copyright (c) 2023 - Present Cory Ginsberg
// Licensed under Apache License 2.0
//

import SwiftUI

struct CommentListLoadedView: View {
  @State var algoliaItems: [Comment]

  var body: some View {
    ForEach(algoliaItems) { comment in
      CommentThread(
        comment: comment
      )
      .padding(.leading, 10.0)
    }
  }
}

// #Preview {
//  CommentListLoadedView()
// }
