//
//  HeadGear.swift
//  ikalendar2
//
//  Created by Tianwei Zhang on 4/7/21.
//

// MARK: - HeadGear

/// Data model for the head gears.
enum HeadGear: Int, Identifiable, CaseIterable {
  case headlampHelmet = 21000
  case dustBlocker2000 = 21001
  case weldingMask = 21002
  case beekeeperHat = 21003
  case octoleetGoggles = 21004
  case capOfLegend = 21005
  case oceanicHardHat = 21006
  case workersHeadTowel = 21007
  case workersCap = 21008
  case sailorCap = 21009

  var id: Int { rawValue }
}

extension HeadGear {
  var name: String {
    switch self {
    case .headlampHelmet: return "Headlamp Helmet"
    case .dustBlocker2000: return "Dust Blocker 2000"
    case .weldingMask: return "Welding Mask"
    case .beekeeperHat: return "Beekeeper Hat"
    case .octoleetGoggles: return "Octoleet Goggles"
    case .capOfLegend: return "Cap of Legend"
    case .oceanicHardHat: return "Oceanic Hard Hat"
    case .workersHeadTowel: return "Worker's Head Towel"
    case .workersCap: return "Worker's Cap"
    case .sailorCap: return "Sailor Cap"
    }
  }
}

extension HeadGear {
  var key: String {
    switch self {
    case .headlampHelmet: return "Hed_COP100"
    case .dustBlocker2000: return "Hed_COP101"
    case .weldingMask: return "Hed_COP102"
    case .beekeeperHat: return "Hed_COP103"
    case .octoleetGoggles: return "Hed_COP104"
    case .capOfLegend: return "Hed_COP105"
    case .oceanicHardHat: return "Hed_COP106"
    case .workersHeadTowel: return "Hed_COP107"
    case .workersCap: return "Hed_COP108"
    case .sailorCap: return "Hed_COP109"
    }
  }
}

extension HeadGear {
  var imgFiln: String {
    let prefix = "S2_Gear_Headgear_"
    let content = name.replacingOccurrences(of: " ", with: "_")
    return prefix + content
  }

  var imgFilnSmall: String { key }
}
