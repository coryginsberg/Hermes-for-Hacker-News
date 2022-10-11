//
//  HackerNewsAppApp.swift
//  HackerNewsApp
//
//  Created by Cory Ginsberg on 10/11/22.
//

import SwiftUI

@main
struct HackerNewsAppApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
