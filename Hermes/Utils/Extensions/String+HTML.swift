//
//  String+HTML.swift
//  AttributedString
//
//  Created by Costantino Pistagna on 08/11/2017.
//  Copyright © 2017 sofapps.it All rights reserved.
//

import Foundation
import UIKit

extension UIColor {
  var hexString: String? {
    if let components = cgColor.components {
      let red = components[0]
      let green = components[1]
      let blue = components[2]
      return String(format: "%02X%02X%02X", Int(red * 255), Int(green * 255), Int(blue * 255))
    }
    return nil
  }
}

extension String {
  var html2Attributed: NSAttributedString? {
    do {
      guard let data = data(using: String.Encoding.utf8) else {
        return nil
      }
      return try NSAttributedString(data: data,
                                    options: [.documentType: NSAttributedString.DocumentType.html,
                                              .characterEncoding: String.Encoding.utf8.rawValue],
                                    documentAttributes: nil)
    } catch {
      print("error: ", error)
      return nil
    }
  }

  var htmlAttributed: (NSAttributedString?, NSDictionary?) {
    do {
      guard let data = data(using: String.Encoding.utf8) else {
        return (nil, nil)
      }

      var dict: NSDictionary?
      dict = NSMutableDictionary()

      return try (NSAttributedString(data: data,
                                     options: [.documentType: NSAttributedString.DocumentType.html,
                                               .characterEncoding: String.Encoding.utf8.rawValue],
                                     documentAttributes: &dict), dict)
    } catch {
      print("error: ", error)
      return (nil, nil)
    }
  }

  func htmlAttributed(color: UIColor) -> NSAttributedString? {
    do {
      let htmlCSSString = "<style>" +
        "html *" +
        "{" +
        "font-size: 15pt !important;" +
        "color: #000000 !important;" +
//        "font-family: \(font.familyName), Helvetica !important;" +
        "}</style> \(self)"

      guard let data = htmlCSSString.data(using: String.Encoding.utf8) else {
        return nil
      }

      return try NSAttributedString(data: data,
                                    options: [.documentType: NSAttributedString.DocumentType.html,
                                              .characterEncoding: String.Encoding.utf8.rawValue],
                                    documentAttributes: nil)
    } catch {
      print("error: ", error)
      return nil
    }
  }

  func htmlAttributed(family: String?, size: CGFloat, color: UIColor) -> NSAttributedString? {
    do {
      let htmlCSSString = "<style>" +
        "html *" +
        "{" +
        "font-size: \(size)pt !important;" +
        "color: #\(color.hexString ?? "000000") !important;" +
        "font-family: \(family ?? "Helvetica"), Helvetica !important;" +
        "}</style> \(self)"

      guard let data = htmlCSSString.data(using: String.Encoding.utf8) else {
        return nil
      }

      return try NSAttributedString(data: data,
                                    options: [.documentType: NSAttributedString.DocumentType.html,
                                              .characterEncoding: String.Encoding.utf8.rawValue],
                                    documentAttributes: nil)
    } catch {
      print("error: ", error)
      return nil
    }
  }
}
