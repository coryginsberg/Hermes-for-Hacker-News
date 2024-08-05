//
// Copyright (c) 2023 - Present Cory Ginsberg
// Licensed under Apache License 2.0
//
import SwiftData
import UIKit

@Model
final class Author {
  var username: String
  // NOTE: Green (newb) users are only highlighed when logged in
  @Attribute(.transformable(by: UIColorValueTransformer.self)) var color: UIColor?

  init(username: String, color: UIColor? = nil) {
    self.username = username
    self.color = color
  }
}

// MARK: - UIColorValueTransformer for UIColor support in SwiftData

@objc(UIColorValueTransformer) final class UIColorValueTransformer: ValueTransformer {
  override static func transformedValueClass() -> AnyClass {
    return UIColor.self
  }

  // return data
  override func transformedValue(_ value: Any?) -> Any? {
    guard let color = value as? UIColor else { return nil }
    do {
      let data = try NSKeyedArchiver.archivedData(withRootObject: color, requiringSecureCoding: true)
      return data
    } catch {
      return nil
    }
  }

  // return UIColor
  override func reverseTransformedValue(_ value: Any?) -> Any? {
    guard let data = value as? Data else { return nil }

    do {
      let color = try NSKeyedUnarchiver.unarchivedObject(ofClass: UIColor.self, from: data)
      return color
    } catch {
      return nil
    }
  }

  override static func allowsReverseTransformation() -> Bool {
    true
  }
}
