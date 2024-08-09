//
//  String+HTML.swift
//  AttributedString
//
//  Created by Costantino Pistagna on 08/11/2017.
//  Copyright © 2017 sofapps.it All rights reserved.
//

import Foundation
import UIKit

// MARK: - UIColor init from hex code

extension UIColor {
  convenience init(hexColor: String) {
    var cString: String = hexColor.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()

    if cString.hasPrefix("#") {
      cString.remove(at: cString.startIndex)
    }

    if (cString.count) != 6 {
      self.init(.gray)
    }

    var rgbValue: UInt64 = 0
    Scanner(string: cString).scanHexInt64(&rgbValue)
    self.init(
      red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
      green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
      blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
      alpha: CGFloat(1.0)
    )
  }
}
