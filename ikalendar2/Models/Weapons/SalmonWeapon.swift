//
//  SalmonWeapon.swift
//  ikalendar2
//
//  Created by Tianwei Zhang on 4/4/21.
//

import Foundation

// MARK: - SalmonWeapon

/// Wrapper data model for all of the salmon run weapons.
/// Not CaseIterable.
enum SalmonWeapon: Equatable {
  case regular(IkaWeapon)
  case random(RandomWeapon)
}

extension SalmonWeapon {
  init?(_ id: Int) {
    if id >= 0 {
      guard let weapon = IkaWeapon(rawValue: id) else {
        return nil
      }
      self = .regular(weapon)
    } else {
      guard let weapon = RandomWeapon(rawValue: id) else {
        return nil
      }
      self = .random(weapon)
    }
  }
}

extension SalmonWeapon {
  var name: String {
    switch self {
    case let .regular(weapon):
      return weapon.name
    case let .random(weapon):
      return weapon.name
    }
  }

  var key: String {
    switch self {
    case let .regular(weapon):
      return weapon.key
    case let .random(weapon):
      return weapon.key
    }
  }

  var imgFiln: String {
    switch self {
    case let .regular(weapon):
      return weapon.imgFiln
    case let .random(weapon):
      return weapon.imgFiln
    }
  }

  var imgFilnSmall: String {
    switch self {
    case let .regular(weapon):
      return weapon.imgFilnSmall
    case let .random(weapon):
      return weapon.imgFilnSmall
    }
  }
}
