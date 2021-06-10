//
//  FlatMode.swift
//  ikalendar2
//
//  Created by Tianwei Zhang on 4/12/21.
//

import Foundation

/// Data model for the flattened game modes.
enum FlatMode: String, Equatable, Identifiable, CaseIterable {
  case regular
  case gachi
  case league
  case salmon

  var id: String { rawValue }

  var name: String {
    switch self {
    case .regular:
      return BattleMode.regular.name
    case .gachi:
      return BattleMode.gachi.name
    case .league:
      return BattleMode.league.name
    case .salmon:
      return GameMode.salmon.name
    }
  }

  var shortName: String {
    switch self {
    case .regular:
      return BattleMode.regular.shortName
    case .gachi:
      return BattleMode.gachi.shortName
    case .league:
      return BattleMode.league.shortName
    case .salmon:
      return GameMode.salmon.shortName
    }
  }

  var imgFiln: String {
    switch self {
    case .regular:
      return BattleMode.regular.imgFilnMid
    case .gachi:
      return BattleMode.gachi.imgFilnMid
    case .league:
      return BattleMode.league.imgFilnMid
    case .salmon:
      return "salmon"
    }
  }

  var imgFilnLarge: String {
    switch self {
    case .regular:
      return BattleMode.regular.imgFilnLarge
    case .gachi:
      return BattleMode.gachi.imgFilnLarge
    case .league:
      return BattleMode.league.imgFilnLarge
    case .salmon:
      return "grizz"
    }
  }
}
