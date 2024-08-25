//
// Copyright (c) 2023 - Present Cory Ginsberg
// Licensed under Apache License 2.0
//

import SwiftUI

extension List {
  func postListNavigation(
    sort: Binding<SortOption>,
    refreshFetch: @escaping () -> Void
  ) -> some View {
    navigationTitle("Posts")
      .listStyle(.plain)
      .refreshable {
        refreshFetch()
      }
      .listRowBackground(Color.clear)
      .listSectionSeparator(.hidden)
      .toolbar {
        PostListSortMenu(sort: sort)
      }
  }
}
