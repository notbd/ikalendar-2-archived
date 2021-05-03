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
      return MatchMode.regular.name
    case .gachi:
      return MatchMode.gachi.name
    case .league:
      return MatchMode.league.name
    case .salmon:
      return GameMode.salmon.name
    }
  }

  var shortName: String {
    switch self {
    case .regular:
      return MatchMode.regular.shortName
    case .gachi:
      return MatchMode.gachi.shortName
    case .league:
      return MatchMode.league.shortName
    case .salmon:
      return GameMode.salmon.shortName
    }
  }

  var imgFiln: String {
    switch self {
    case .regular:
      return MatchMode.regular.imgFilnMid
    case .gachi:
      return MatchMode.gachi.imgFilnMid
    case .league:
      return MatchMode.league.imgFilnMid
    case .salmon:
      return "salmon"
    }
  }

  var imgFilnLarge: String {
    switch self {
    case .regular:
      return MatchMode.regular.imgFilnLarge
    case .gachi:
      return MatchMode.gachi.imgFilnLarge
    case .league:
      return MatchMode.league.imgFilnLarge
    case .salmon:
      return "grizz"
    }
  }
}
