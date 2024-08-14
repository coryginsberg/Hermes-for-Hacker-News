//
// Copyright (c) 2024 Cory Ginsberg.
// Licensed under the Apache License, Version 2.0
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
