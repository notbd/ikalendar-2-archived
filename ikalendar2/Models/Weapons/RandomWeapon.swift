//
//  RandomWeapon.swift
//  ikalendar2
//
//  Created by Tianwei Zhang on 4/4/21.
//

import Foundation

// MARK: - RandomWeapon

/// Data model for the random weapons.
enum RandomWeapon: Int, Identifiable, CaseIterable {
  case green = -1
  case gold = -2

  var id: Int { rawValue }
}

extension RandomWeapon {
  var name: String {
    switch self {
    case .green:
      return "Random"
    case .gold:
      return "Grizzco Random"
    }
  }
}

extension RandomWeapon {
  var key: String {
    switch self {
    case .green:
      return "Random"
    case .gold:
      return "Grizzco Random"
    }
  }
}

extension RandomWeapon {
  var imgFiln: String { name.replacingOccurrences(of: " ", with: "_") }
  var imgFilnSmall: String { imgFiln }
}
