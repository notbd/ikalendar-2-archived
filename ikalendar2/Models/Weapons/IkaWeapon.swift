//
//  IkaWeapon.swift
//  ikalendar2
//
//  Created by Tianwei Zhang on 4/2/21.
//

// MARK: - IkaWeapon

/// Data model for the normal weapons.
enum IkaWeapon: Int, Identifiable, CaseIterable {
  // Shooters
  case splooshOMatic = 0
  case splattershotJr = 10
  case splashOMatic = 20
  case aerosprayMG = 30
  case splattershot = 40
  case gal52 = 50
  case nZap85 = 60
  case splattershotPro = 70
  case gal96 = 80
  case jetSquelcher = 90
  // Blasters
  case lunaBlaster = 200
  case blaster = 210
  case rangeBlaster = 220
  case clashBlaster = 230
  case rapidBlaster = 240
  case rapidBlasterPro = 250
  // Nozzlenoses
  case l3Nozzlenose = 300
  case h3Nozzlenose = 310
  // Squeezer
  case squeezer = 400
  // Rollers
  case carbonRoller = 1000
  case splatRoller = 1010
  case dynamoRoller = 1020
  case flingzaRoller = 1030
  case inkbrush = 1100
  case octobrush = 1110
  // Chargers
  case classicSquiffer = 2000
  case splatCharger = 2010
  case splatterscope = 2020
  case eliter4K = 2030
  case eliter4KScope = 2040
  case bamboozler14MkI = 2050
  case gooTuber = 2060
  // Sloshers
  case slosher = 3000
  case triSlosher = 3010
  case sloshingMachine = 3020
  case bloblobber = 3030
  case explosher = 3040
  // Splatlings
  case miniSplatling = 4000
  case heavySplatling = 4010
  case hydraSplatling = 4020
  case ballpointSplatling = 4030
  case nautilus47 = 4040
  // Dualies
  case dappleDualies = 5000
  case splatDualies = 5010
  case gloogaDualies = 5020
  case dualieSquelchers = 5030
  case darkTetraDualies = 5040
  // Brellas
  case splatBrella = 6000
  case tentaBrella = 6010
  case undercoverBrella = 6020

  var id: Int { rawValue }
}

extension IkaWeapon {
  var name: String {
    switch self {
    // Shooters
    case .splooshOMatic: return "Sploosh-o-matic"
    case .splattershotJr: return "Splattershot Jr."
    case .splashOMatic: return "Splash-o-matic"
    case .aerosprayMG: return "Aerospray MG"
    case .splattershot: return "Splattershot"
    case .gal52: return ".52 Gal"
    case .nZap85: return "N-ZAP '85"
    case .splattershotPro: return "Splattershot Pro"
    case .gal96: return ".96 Gal"
    case .jetSquelcher: return "Jet Squelcher"
    // Blasters
    case .lunaBlaster: return "Luna Blaster"
    case .blaster: return "Blaster"
    case .rangeBlaster: return "Range Blaster"
    case .clashBlaster: return "Clash Blaster"
    case .rapidBlaster: return "Rapid Blaster"
    case .rapidBlasterPro: return "Rapid Blaster Pro"
    // Nozzlenoses
    case .l3Nozzlenose: return "L-3 Nozzlenose"
    case .h3Nozzlenose: return "H-3 Nozzlenose"
    // Squeezer
    case .squeezer: return "Squeezer"
    // Rollers
    case .carbonRoller: return "Carbon Roller"
    case .splatRoller: return "Splat Roller"
    case .dynamoRoller: return "Dynamo Roller"
    case .flingzaRoller: return "Flingza Roller"
    case .inkbrush: return "Inkbrush"
    case .octobrush: return "Octobrush"
    // Chargers
    case .classicSquiffer: return "Classic Squiffer"
    case .splatCharger: return "Splat Charger"
    case .splatterscope: return "Splatterscope"
    case .eliter4K: return "E-liter 4K"
    case .eliter4KScope: return "E-liter 4K Scope"
    case .bamboozler14MkI: return "Bamboozler 14 Mk I"
    case .gooTuber: return "Goo Tuber"
    // Sloshers
    case .slosher: return "Slosher"
    case .triSlosher: return "Tri-Slosher"
    case .sloshingMachine: return "Sloshing Machine"
    case .bloblobber: return "Bloblobber"
    case .explosher: return "Explosher"
    // Splatlings
    case .miniSplatling: return "Mini Splatling"
    case .heavySplatling: return "Heavy Splatling"
    case .hydraSplatling: return "Hydra Splatling"
    case .ballpointSplatling: return "Ballpoint Splatling"
    case .nautilus47: return "Nautilus 47"
    // Dualies
    case .dappleDualies: return "Dapple Dualies"
    case .splatDualies: return "Splat Dualies"
    case .gloogaDualies: return "Glooga Dualies"
    case .dualieSquelchers: return "Dualie Squelchers"
    case .darkTetraDualies: return "Dark Tetra Dualies"
    // Brellas
    case .splatBrella: return "Splat Brella"
    case .tentaBrella: return "Tenta Brella"
    case .undercoverBrella: return "Undercover Brella"
    }
  }
}

extension IkaWeapon {
  var key: String {
    switch self {
    // Shooters
    case .splooshOMatic: return "Wst_Shooter_Short_00"
    case .splattershotJr: return "Wst_Shooter_First_00"
    case .splashOMatic: return "Wst_Shooter_Precision_00"
    case .aerosprayMG: return "Wst_Shooter_Blaze_00"
    case .splattershot: return "Wst_Shooter_Normal_00"
    case .gal52: return "Wst_Shooter_Gravity_00"
    case .nZap85: return "Wst_Shooter_QuickMiddle_00"
    case .splattershotPro: return "Wst_Shooter_Expert_00"
    case .gal96: return "Wst_Shooter_Heavy_00"
    case .jetSquelcher: return "Wst_Shooter_Long_00"
    // Blasters
    case .lunaBlaster: return "Wst_Shooter_BlasterShort_00"
    case .blaster: return "Wst_Shooter_BlasterMiddle_00"
    case .rangeBlaster: return "Wst_Shooter_BlasterLong_00"
    case .clashBlaster: return "Wst_Shooter_BlasterLightShort_00"
    case .rapidBlaster: return "Wst_Shooter_BlasterLight_00"
    case .rapidBlasterPro: return "Wst_Shooter_BlasterLightLong_00"
    // Nozzlenoses
    case .l3Nozzlenose: return "Wst_Shooter_TripleQuick_00"
    case .h3Nozzlenose: return "Wst_Shooter_TripleMiddle_00"
    // Squeezer
    case .squeezer: return "Wst_Shooter_Flash_00"
    // Rollers
    case .carbonRoller: return "Wst_Roller_Compact_00"
    case .splatRoller: return "Wst_Roller_Normal_00"
    case .dynamoRoller: return "Wst_Roller_Heavy_00"
    case .flingzaRoller: return "Wst_Roller_Hunter_00"
    case .inkbrush: return "Wst_Roller_BrushMini_00"
    case .octobrush: return "Wst_Roller_BrushNormal_00"
    // Chargers
    case .classicSquiffer: return "Wst_Charger_Quick_00"
    case .splatCharger: return "Wst_Charger_Normal_00"
    case .splatterscope: return "Wst_Charger_NormalScope_00"
    case .eliter4K: return "Wst_Charger_Long_00"
    case .eliter4KScope: return "Wst_Charger_LongScope_00"
    case .bamboozler14MkI: return "Wst_Charger_Light_00"
    case .gooTuber: return "Wst_Charger_Keeper_00"
    // Sloshers
    case .slosher: return "Wst_Slosher_Strong_00"
    case .triSlosher: return "Wst_Slosher_Diffusion_00"
    case .sloshingMachine: return "Wst_Slosher_Launcher_00"
    case .bloblobber: return "Wst_Slosher_Bathtub_00"
    case .explosher: return "Wst_Slosher_Washtub_00"
    // Splatlings
    case .miniSplatling: return "Wst_Spinner_Quick_00"
    case .heavySplatling: return "Wst_Spinner_Standard_00"
    case .hydraSplatling: return "Wst_Spinner_Hyper_00"
    case .ballpointSplatling: return "Wst_Spinner_Downpour_00"
    case .nautilus47: return "Wst_Spinner_Serein_00"
    // Dualies
    case .dappleDualies: return "Wst_Twins_Short_00"
    case .splatDualies: return "Wst_Twins_Normal_00"
    case .gloogaDualies: return "Wst_Twins_Gallon_00"
    case .dualieSquelchers: return "Wst_Twins_Dual_00"
    case .darkTetraDualies: return "Wst_Twins_Stepper_00"
    // Brellas
    case .splatBrella: return "Wst_Umbrella_Normal_00"
    case .tentaBrella: return "Wst_Umbrella_Wide_00"
    case .undercoverBrella: return "Wst_Umbrella_Compact_00"
    }
  }
}

extension IkaWeapon {
  var imgFiln: String {
    let prefix = "S2_Weapon_Main_"
    let content = name.replacingOccurrences(of: " ", with: "_")
    return prefix + content
  }

  var imgFilnSmall: String { key }
}
