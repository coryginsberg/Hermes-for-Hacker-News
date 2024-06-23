//
// Copyright (c) 2023 - Present Cory Ginsberg
// Licensed under Apache License 2.0
//

import SwiftData
import SwiftUI

/// A view that creates a model container before showing preview content.
///
/// Use this view type only for previews, and only when you need
/// to create a container before showing the view content. As an example
/// of how to use this view, see the preview for `QuakeRow`.
struct ModelContainerPreview<Content: View>: View {
  var content: () -> Content
  var addPadding: Bool = false
  let container: ModelContainer

  /// Creates a view that creates the specified model container before
  /// displaying the preview content.
  init(
    _ modelContainer: @escaping () throws -> ModelContainer,
    addPadding padding: Bool = false,
    @ViewBuilder content: @escaping () -> Content
  ) {
    self.content = content
    self.addPadding = padding
    do {
      self.container = try MainActor.assumeIsolated(modelContainer)
    } catch {
      fatalError("Failed to create the model container: \(error.localizedDescription)")
    }
  }

  var body: some View {
    if addPadding {
      VStack {
        content()
          .modelContainer(container)
      }.padding()
    } else {
      content()
        .modelContainer(container)
    }
  }
}
