//
//  GrizzcoWeapon.swift
//  ikalendar2
//
//  Created by Tianwei Zhang on 4/4/21.
//

import Foundation

// MARK: - GrizzcoWeapon

/// Data model for the grizzco weapons.
enum GrizzcoWeapon: String, Identifiable, CaseIterable {
  case brella = "Grizzco Brella"
  case slosher = "Grizzco Slosher"
  case blaster = "Grizzco Blaster"
  case charger = "Grizzco Charger"

  var id: String { rawValue }
}

extension GrizzcoWeapon {
  var name: String {
    switch self {
    case .brella: return "Grizzco Brella"
    case .slosher: return "Grizzco Slosher"
    case .blaster: return "Grizzco Blaster"
    case .charger: return "Grizzco Charger"
    }
  }
}

extension GrizzcoWeapon {
  var key: String {
    switch self {
    case .brella: return "Wst_Umbrella_CoopAutoAssault"
    case .slosher: return "Wst_Slosher_CoopVase"
    case .blaster: return "Wst_Shooter_BlasterCoopBurst"
    case .charger: return "Wst_Charger_CoopSpark"
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
