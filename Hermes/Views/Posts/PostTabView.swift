//
//  ContentView.swift
//  Hermes
//
//  Created by Cory Ginsberg on 3/28/24.
//

import SwiftData
import SwiftUI

struct PostTabView: View {
  @Environment(ViewModel.self) private var viewModel
  @Environment(\.modelContext) private var modelContext
  @Environment(\.scenePhase) private var scenePhase

  @State private var selectedId: Post.ID?

  var body: some View {
    NavigationSplitView {
      PostList(selectedId: $selectedId)
        .listStyle(.plain)
        .navigationTitle("Posts")
    } detail: {
      Text("Select an item")
    }
    .onChange(of: scenePhase) { _, scenePhase in
      if scenePhase == .active {
        //        viewModel.update(modelContext: modelContext)
      }
    }
    .task {
      await HNSearchResults.refresh(modelContext: modelContext)
    }
    .onAppear {
#if DEBUG
      log(category: "sqlite").debug("\(modelContext.sqliteCommand)")
#endif
    }
  }
}

#Preview {
  PostTabView()
    .environment(ViewModel())
    .modelContainer(for: Post.self, inMemory: true)
}
