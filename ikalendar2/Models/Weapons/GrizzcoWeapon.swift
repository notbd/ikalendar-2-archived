//
//  GrizzcoWeapon.swift
//  ikalendar2
//
//  Created by Tianwei Zhang on 4/4/21.
//

import Foundation

// MARK: - GrizzcoWeapon

/// Data model for the grizzco weapons.
enum GrizzcoWeapon: Int, Identifiable, CaseIterable {
  case blaster = 20000
  case brella = 20010
  case charger = 20020
  case slosher = 20030

  var id: Int { rawValue }
}

extension GrizzcoWeapon {
  var name: String {
    switch self {
    case .blaster: return "Grizzco Blaster"
    case .brella: return "Grizzco Brella"
    case .charger: return "Grizzco Charger"
    case .slosher: return "Grizzco Slosher"
    }
  }
}

extension GrizzcoWeapon {
  var key: String {
    switch self {
    case .blaster: return "Wst_Shooter_BlasterCoopBurst"
    case .brella: return "Wst_Umbrella_CoopAutoAssault"
    case .charger: return "Wst_Charger_CoopSpark"
    case .slosher: return "Wst_Slosher_CoopVase"
    }
  }
}

extension GrizzcoWeapon {
  var imgFiln: String {
    let prefix = "S2_Weapon_Main_"
    let content = name.replacingOccurrences(of: " ", with: "_")
    return prefix + content
  }

  var imgFilnSmall: String { key }
}
