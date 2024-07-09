//
// Copyright (c) 2023 - Present Cory Ginsberg
// Licensed under Apache License 2.0
//

import Foundation
import os.log

enum Level: String {
  case debug
  case info
  case warning
  case fault
  case critical
}

@MainActor
public protocol Logging {
  var subsystem: String { get }
  var category: String { get }
}

extension Logging {
  var subsystem: String {
    "com.coryginsberg.Hermes"
  }

  var category: String {
    "General"
  }

  // swiftlint:disable:next identifier_name
  func Log(_ level: Level, message: String, fileName: String = #file, line: Int = #line) {
    Slog.log(level, message: message, fileName: fileName, line: line, subsystem: subsystem, category: category)
  }

  // swiftlint:disable:next identifier_name
  func LogError(_ error: Error, message: String = "", fileName: String = #file, line: Int = #line) {
    Slog.error(error, message: message, fileName: fileName, line: line, subsystem: subsystem, category: category)
  }
}

struct Slog: Logging {
  static func log(_ level: Level,
                  message: String,
                  fileName: String = #file,
                  line: Int = #line,
                  subsystem: String = "com.coryginsberg.Hermes",
                  category: String = "General") {
    let logger = Logger(subsystem: subsystem, category: category)
    let thread = Thread.current.isMainThread ? "🟢" : "🟡"
    let fileNameNoPath = (fileName as NSString).lastPathComponent
    let message = "\(thread) [\(fileNameNoPath):\(line)] \(message)"
    switch level {
    case .warning:
      logger.warning("\(message)")
    case .debug:
      logger.debug("\(message)")
    case .fault:
      logger.fault("\(message)")
    case .info:
      logger.info("\(message)")
    case .critical:
      logger.critical("\(message)")
    }
  }

  static func error(
    _ error: Error,
    message: String = "",
    fileName: String = #file,
    line: Int = #line,
    subsystem: String = "com.coryginsberg.Hermes",
    category: String = "General") {
    let logger = Logger(subsystem: subsystem, category: category)
    let thread = Thread.current.isMainThread ? "🟢" : "🟡"
    let fileNameNoPath = (fileName as NSString).lastPathComponent
    let message = "‼️ \(thread) [\(fileNameNoPath):\(line)] \(message) \(error.localizedDescription)\n\(error)"
    logger.error("\(message)")
    print("\(message)")
  }
}
