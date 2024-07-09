//
// Copyright (c) 2023 - Present Cory Ginsberg
// Licensed under Apache License 2.0
//

import AlertToast
import SwiftUI

/**
 Observable alert modal that can be called from anywhere in the app. To call,
 add a `@EnvironmentObject var viewModel: AlertViewModel` to the SwiftUI View
 then you can present the alert using `viewModel.alertToast`.

 # Examples:

 ```swift
 import AlertToast

 struct ContentView: View {
  @EnvironmentObject var viewModel: AlertViewModel

  var body: some View {
    NavigationView{
       ...
    }
    .toast(isPresenting: $viewModel.show) {
        // Return AlertToast from ObservableObject
        viewModel.alertToast
    }
  }
 }
 ```

 You can also change the alert type, present a different one and show (because
 of didSet):

 ```swift
 import AlertToast

 Button("Change Alert Type") {
    viewModel.alertToast = AlertToast(displayMode: .hud,
                                      type: .complete(.green),
                                      title: "Completed!",
                                      subTitle: nil)
 }
 ```
 */

@MainActor
public class AlertViewModal: ObservableObject {
  @Published var show = false
  @Published var alertToast = AlertToast(
    displayMode: .hud,
    type: .regular,
    title: "LOREM IPSUM"
  ) {
    didSet {
      show.toggle()
    }
  }
}
