//
//  BattleMode.swift
//  ikalendar2
//
//  Created by Tianwei Zhang on 3/26/21.
//

// MARK: - BattleMode

/// Data model for the battle modes.
enum BattleMode: String, Identifiable, CaseIterable, Equatable {
  case regular
  case gachi
  case league

  var id: String { rawValue }
}

extension BattleMode {
  var name: String {
    switch self {
    case .regular: return "Regular Battle"
    case .gachi: return "Ranked Battle"
    case .league: return "League Battle"
    }
  }
}

extension BattleMode {
  var shortName: String {
    switch self {
    case .regular: return "Regular"
    case .gachi: return "Ranked"
    case .league: return "League"
    }
  }
}

extension BattleMode {
  var imgFilnSmall: String { rawValue + "_small" }
  var imgFilnMid: String { rawValue + "_mid" }
  var imgFilnLarge: String { rawValue + "_large" }
}
