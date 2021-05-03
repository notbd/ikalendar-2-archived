//
//  LocalizedStringKey+Ext.swift
//  ikalendar2
//
//  Created by Tianwei Zhang on 4/21/21.
//

import SwiftUI

extension LocalizedStringKey {
  // imagine `self` is equal to LocalizedStringKey("KEY_HERE")

  var stringKey: String {
    let description = "\(self)"
    // In this example description will be
    // `LocalizedStringKey(key: "KEY_HERE", hasFormatting: false, arguments: [])`

    let components = description.components(separatedBy: "key: \"")
      .map { $0.components(separatedBy: "\",") }
    // Here we separate the string by its components.
    // In `LocalizedStringKey(key: "KEY_HERE", hasFormatting: false, arguments: [])`
    // our key lays between two strings which are `key: "` and `",`.
    // if we manage to get what is between `key: "` and `",`, that would be our Localization Key
    // which in this example is `KEY_HERE`

    return components[1][0]
    // by trial, we know that `components[1][0]` will always be our localization Key
    // which is `KEY_HERE` in this example.
  }
}

extension LocalizedStringKey {
  /// Get the translated value for the LocalizedStringKey.
  /// - Parameter locale: The locale of the translation(default to .current).
  /// - Returns: The translated String.
  func stringValue(locale: Locale = .current) -> String {
    .localizedString(for: stringKey, locale: locale)
  }
}
