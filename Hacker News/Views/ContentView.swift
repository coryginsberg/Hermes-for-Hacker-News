//
//  ContentView.swift
//  Hacker News
//
//  Created by Cory Ginsberg on 9/30/22.
//

import CoreData
import SwiftUI
import FirebaseCore
import FirebaseDatabaseSwift

struct ContentView: View {
  @Environment(\.managedObjectContext) private var viewContext

  @ObservedObject var fetch = HackerNewsAPI()
  
  var body: some View {
    TabView {
      PostsView(title: "Posts")
        .tabItem {
          Label("Posts", systemImage: "house")
        }
      PostsView(title: "Inbox")
        .tabItem {
          Label("Inbox", systemImage: "envelope.fill")
        }
      PostsView(title: "Profile")
        .tabItem {
          Label("Profile", systemImage: "person.fill")
        }
      PostsView(title: "Settings")
        .tabItem {
          Label("Settings", systemImage: "gearshape.fill")
        }
    }
    .accentColor(Color(.systemOrange))
  }
}

private let itemFormatter: DateFormatter = {
  let formatter = DateFormatter()
  formatter.dateStyle = .short
  formatter.timeStyle = .medium
  return formatter
}()

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

