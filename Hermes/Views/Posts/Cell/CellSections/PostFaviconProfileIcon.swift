//
// Copyright (c) 2023 - Present Cory Ginsberg
// Licensed under Apache License 2.0
//

import SwiftUI

enum Website: String, CaseIterable {
  case github
}

struct PostFaviconProfileIcon: View {
  @Binding var faviconUrl: URL?
  @Binding var sourceDomain: String?

  @State var website: Website?

  var body: some View {
    Group {
      if let website {
        Image("Logos/\(website.rawValue)")
          .resizable()
          .frame(width: 25, height: 25, alignment: .bottomTrailing)
          .background(Color(UIColor.systemBackground))
          .clipShape(Circle().size(width: 25, height: 25))
          .offset(x: 20, y: 20)
      }
    }.onChange(of: faviconUrl) {
      if let sourceDomain {
        // Only set `website` if the preview domain contains a path to a user profile
        website = try? Website.allCases.first {
          try sourceDomain.contains(Regex("^\($0.rawValue).*\\/"))
        }
      }
    }
  }
}
