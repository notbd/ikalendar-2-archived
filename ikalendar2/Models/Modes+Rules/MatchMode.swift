//
//  MatchMode.swift
//  ikalendar2
//
//  Created by Tianwei Zhang on 3/26/21.
//

// MARK: - MatchMode

/// Data model for the match modes.
enum MatchMode: String, Identifiable, CaseIterable, Equatable {
  case regular
  case gachi
  case league

  var id: String { rawValue }
}

extension MatchMode {
  var name: String {
    switch self {
    case .regular: return "Regular Battle"
    case .gachi: return "Ranked Battle"
    case .league: return "League Battle"
    }
  }
}

extension MatchMode {
  var shortName: String {
    switch self {
    case .regular: return "Regular"
    case .gachi: return "Ranked"
    case .league: return "League"
    }
  }
}

extension MatchMode {
  var imgFilnSmall: String { rawValue + "_small" }
  var imgFilnMid: String { rawValue + "_mid" }
  var imgFilnLarge: String { rawValue + "_large" }
}
