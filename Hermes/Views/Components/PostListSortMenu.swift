//
// Copyright (c) 2024 Cory Ginsberg.
// Licensed under the Apache License, Version 2.0
//

import SwiftUI

struct PostListSortMenu: View {
  @Environment(\.modelContext) private var modelContext
  @Binding var sort: SortOption
  @State private var isDatePickerPresented: Bool = false
  @State private var date: Date = .init()

  var body: some View {
    Menu {
      ForEach(SortOption.allCases) { opt in
        Button {
          if case .front = opt {
            isDatePickerPresented = true
            sort = .front(date)
          } else {
            sort = opt
          }
          do {
            try modelContext.delete(model: Post.self)
          } catch {
            fatalError(error.localizedDescription)
          }
        } label: {
          Text(opt.rawValue.text)
        }.popover(isPresented: $isDatePickerPresented) {
          VStack {
            DatePicker(
              "Time travel to:",
              selection: $date,
              in: PartialRangeThrough(Date.now),
              displayedComponents: [.date]
            ).datePickerStyle(.graphical)
              .presentationCompactAdaptation(.popover)
              .padding(.all, 20)
          }.frame(width: 400, height: 400, alignment: .center)
        }
      }
    }
    label: {
      Text("Sort by")
    }
  }
}
