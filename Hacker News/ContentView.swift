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

    Text("Hello, World!123")
    LazyVStack {
      List(fetch.hnStories) { story in
        VStack(alignment: .leading) {
          Text(story.title)
          Text("\(story.score) points by \(story.by) @ \(story.time) | \(story.descendants)")
        }
      }
    }
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

