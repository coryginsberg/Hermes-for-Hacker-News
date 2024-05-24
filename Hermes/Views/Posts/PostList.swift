////
//// Copyright (c) 2023 - Present Cory Ginsberg
//// Licensed under Apache License 2.0
////
//
// import Foundation
// import SwiftData
// import SwiftUI
//
//// MARK: - PostListView
//
// struct PostList: View {
//  @Environment(ViewModel.self) private var viewModel
//  @Environment(\.modelContext) private var modelContext
//  @Query(sort: \Post.index) private var posts: [Post]
//
//  @Binding var selectedId: Post.ID?
//
//  init(
//    selectedId: Binding<Post.ID?>
//  ) {
//    _selectedId = selectedId
//  }
//
//  var body: some View {
//
//  }
// }
//
//// MARK: - PostsListView_Previews
//
// struct PostsList_Previews: PreviewProvider {
//  static var previews: some View {
//    PostList(selectedId: Binding.constant(nil))
//      .environment(ViewModel())
//      .modelContainer(for: Post.self, inMemory: true)
//  }
// }
