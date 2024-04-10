//
//  ModelContext+SQLite.swift
//  Hermes for Hacker News 2
//
//  Created by Cory Ginsberg on 4/2/24.
//

import Foundation
import SwiftData

extension ModelContext {
  /// Prints the directory for where the CoreData/SwiftData (SQLite) tables are stored
  ///
  /// Once you get the directory, copy the whole thing (starting with sqlite3 and including quotes) and paste that into
  /// a terminal. That will open an SQLite promt that allows reading from and writing to the database.
  ///
  /// > Note: CoreData/SwiftData table names all start with the letter 'Z'.
  ///
  /// Some commands to know:
  /// - `.schema` - Shows the schema for each table.
  /// - `.table` - List the names of each table.
  /// - `SELECT * FROM {table}` - show all objects inside the table.
  ///
  /// - returns: The command to view the database. Copy the whole thing into a terminal window to view.
  var sqliteCommand: String {
    if let url = container.configurations.first?.url.path(percentEncoded: false) {
      "sqlite3 \"\(url)\""
    } else {
      "No SQLite database found."
    }
  }
}
