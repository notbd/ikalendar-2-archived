//
//  BattleRule.swift
//  ikalendar2
//
//  Created by Tianwei Zhang on 3/26/21.
//

// MARK: - BattleRule

/// Data model for the battle rules.
enum BattleRule: String, Identifiable, CaseIterable, Equatable {
  case turfWar = "Turf War"
  case splatZones = "Splat Zones"
  case towerControl = "Tower Control"
  case rainmaker = "Rainmaker"
  case clamBlitz = "Clam Blitz"

  var id: String { rawValue }
}

extension BattleRule {
  var key: String {
    switch self {
    case .turfWar: return "turf_war"
    case .splatZones: return "splat_zones"
    case .towerControl: return "tower_control"
    case .rainmaker: return "rainmaker"
    case .clamBlitz: return "clam_blitz"
    }
  }
}

extension BattleRule {
  var name: String {
    switch self {
    case .turfWar: return "Turf War"
    case .splatZones: return "Splat Zones"
    case .towerControl: return "Tower Control"
    case .rainmaker: return "Rainmaker"
    case .clamBlitz: return "Clam Blitz"
    }
  }
}

extension BattleRule {
  var description: String {
    switch self {
    case .turfWar: return "In a Turf War, teams have three minutes to cover the ground with ink. " +
      "The team that claims the most turf with their ink wins the battle."
    case .splatZones: return "Plays similarly to the King of the Hill mode from other video " +
      "games. It revolves around a central \"zone\" or \"zones\", which players must attempt " +
      "to cover in ink. Whoever retains the zone for a certain amount of time wins."
    case .towerControl: return "A player must take control of a tower located in the center of " +
      "a map and ride it towards the enemy base. " +
      "The first team to get the tower to their enemy's base wins."
    case .rainmaker: return "A player must grab and take the Rainmaker weapon to a pedestal near " +
      "the enemy team's spawn point. The team who carries the Rainmaker furthest " +
      "towards their respective pedestal wins."
    case .clamBlitz: return "Players pick up clams scattered around the stage and try to score " +
      "as many points as they can by throwing the clams in their respective goal."
    }
  }
}

extension BattleRule {
  var releaseDate: String {
    switch self {
    case .turfWar: return "06/02/2015"
    case .splatZones: return "06/02/2015"
    case .towerControl: return "07/02/2015"
    case .rainmaker: return "08/15/2015"
    case .clamBlitz: return "12/13/2017"
    }
  }
}

extension BattleRule {
  var imgFilnMid: String { key + "_mid" }
  var imgFilnLarge: String { key + "_large" }
}
