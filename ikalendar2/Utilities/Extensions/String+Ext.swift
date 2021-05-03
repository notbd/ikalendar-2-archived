//
//  String+Ext.swift
//  ikalendar2
//
//  Created by Tianwei Zhang on 4/21/21.
//

import SwiftUI

extension String {
  /// Convert a string to a LocalizedStringKey with that string as the literal.
  /// - Returns: The LocalizedStringKey.
  func localizedStringKey() -> LocalizedStringKey {
    LocalizedStringKey(self)
  }
}

extension String {
  /// Translate a string using the provided localizations in the bundle.
  /// - Parameters:
  ///   - key: The string to be translated from.
  ///   - locale: The locale of the translation(default to .current).
  /// - Returns: The translated String.
  static func localizedString(
    for key: String,
    locale: Locale = .current)
  -> String {
    let language = locale.languageCode
    let path = Bundle.main.path(forResource: language, ofType: "lproj")!
    let bundle = Bundle(path: path)!
    let localizedString = NSLocalizedString(key, bundle: bundle, comment: "")

    return localizedString
  }
}
