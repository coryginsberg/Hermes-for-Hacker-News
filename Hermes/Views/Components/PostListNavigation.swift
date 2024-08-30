//
// Copyright (c) 2023 - Present Cory Ginsberg
// Licensed under Apache License 2.0
//

import SwiftUI

enum Page {
  case postView(Binding<SortOption>)
  case commentsView
  case webView
}

struct NavigationBar: ViewModifier {
  let refreshView: () -> Void

  func body(content: Content) -> some View {
    content
      .listStyle(.plain)
      .listRowBackground(Color.clear)
      .listSectionSeparator(.hidden)
      .refreshable {
        refreshView()
      }
  }
}

struct PostViewNavBar: ViewModifier {
  @Binding var sort: SortOption

  func body(content: Content) -> some View {
    content
      .navigationTitle("Posts")
      .toolbar {
        PostListSortMenu(sort: $sort)
      }
  }
}

struct CommentViewNavBar: ViewModifier {
  func body(content: Content) -> some View {
    content.navigationTitle("Comments")
  }
}

struct WebViewNavBar: ViewModifier {
  func body(content: Content) -> some View {
    content.navigationTitle("Website")
  }
}

extension View {
  private func navigationBarStyle(
    refreshFetch: @escaping () -> Void
  ) -> some View {
    modifier(NavigationBar(refreshView: refreshFetch))
  }

  @ViewBuilder
  func navigationBar(
    for page: Page,
    refreshFetch: @escaping () -> Void
  ) -> some View {
    switch page {
    case .postView(let sort):
      modifier(PostViewNavBar(sort: sort)).navigationBarStyle(refreshFetch: refreshFetch)
    case .commentsView:
      modifier(CommentViewNavBar()).navigationBarStyle(refreshFetch: refreshFetch)
    case .webView:
      modifier(WebViewNavBar()).navigationBarStyle(refreshFetch: refreshFetch)
    }
  }
}
