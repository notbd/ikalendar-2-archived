//
//  MatchStage.swift
//  ikalendar2
//
//  Created by Tianwei Zhang on 3/27/21.
//

// MARK: - MatchStage

/// Data model for the match stages.
enum MatchStage: String, Identifiable, CaseIterable {
  case anchoVGames = "Ancho-V Games"
  case arowanaMall = "Arowana Mall"
  case blackbellySkatepark = "Blackbelly Skatepark"
  case campTriggerfish = "Camp Triggerfish"
  case gobyArena = "Goby Arena"
  case humpbackPumpTrack = "Humpback Pump Track"
  case inkblotArtAcademy = "Inkblot Art Academy"
  case kelpDome = "Kelp Dome"
  case makoMart = "MakoMart"
  case mantaMaria = "Manta Maria"
  // #10
  case morayTowers = "Moray Towers"
  case musselforgeFitness = "Musselforge Fitness"
  case newAlbacoreHotel = "New Albacore Hotel"
  case piranhaPit = "Piranha Pit"
  case portMackerel = "Port Mackerel"
  case shellendorfInstitute = "Shellendorf Institute"
  case shiftyStation = "Shifty Station"
  case skipperPavilion = "Skipper Pavilion"
  case snapperCanal = "Snapper Canal"
  case starfishMainstage = "Starfish Mainstage"
  // #20
  case sturgeonShipyard = "Sturgeon Shipyard"
  case theReef = "The Reef"
  case wahooWorld = "Wahoo World"
  case walleyeWarehouse = "Walleye Warehouse"

  var id: String { rawValue }
}

extension MatchStage {
  var name: String {
    switch self {
    case .anchoVGames: return "Ancho-V Games"
    case .arowanaMall: return "Arowana Mall"
    case .blackbellySkatepark: return "Blackbelly Skatepark"
    case .campTriggerfish: return "Camp Triggerfish"
    case .gobyArena: return "Goby Arena"
    case .humpbackPumpTrack: return "Humpback Pump Track"
    case .inkblotArtAcademy: return "Inkblot Art Academy"
    case .kelpDome: return "Kelp Dome"
    case .makoMart: return "MakoMart"
    case .mantaMaria: return "Manta Maria"
    // #10
    case .morayTowers: return "Moray Towers"
    case .musselforgeFitness: return "Musselforge Fitness"
    case .newAlbacoreHotel: return "New Albacore Hotel"
    case .piranhaPit: return "Piranha Pit"
    case .portMackerel: return "Port Mackerel"
    case .shellendorfInstitute: return "Shellendorf Institute"
    case .shiftyStation: return "Shifty Station"
    case .skipperPavilion: return "Skipper Pavilion"
    case .snapperCanal: return "Snapper Canal"
    case .starfishMainstage: return "Starfish Mainstage"
    // #20
    case .sturgeonShipyard: return "Sturgeon Shipyard"
    case .theReef: return "The Reef"
    case .wahooWorld: return "Wahoo World"
    case .walleyeWarehouse: return "Walleye Warehouse"
    }
  }
}

extension MatchStage {
  var releaseDate: String {
    switch self {
    case .anchoVGames: return "08/01/2018"
    case .arowanaMall: return "02/02/2018"
    case .blackbellySkatepark: return "02/02/2017"
    case .campTriggerfish: return "04/25/2018"
    case .gobyArena: return "03/02/2018"
    case .humpbackPumpTrack: return "07/21/2017"
    case .inkblotArtAcademy: return "07/21/2017"
    case .kelpDome: return "09/16/2017"
    case .makoMart: return "11/25/2017"
    case .mantaMaria: return "08/26/2017"
    // #10
    case .morayTowers: return "07/21/2017"
    case .musselforgeFitness: return "07/21/2017"
    case .newAlbacoreHotel: return "07/01/2018"
    case .piranhaPit: return "03/31/2018"
    case .portMackerel: return "07/21/2017"
    case .shellendorfInstitute: return "01/12/2018"
    case .shiftyStation: return "08/04/2017"
    case .skipperPavilion: return "10/03/2018"
    case .snapperCanal: return "10/06/2017"
    case .starfishMainstage: return "07/21/2017"
    // #20
    case .sturgeonShipyard: return "07/21/2017"
    case .theReef: return "07/21/2017"
    case .wahooWorld: return "06/01/2018"
    case .walleyeWarehouse: return "12/15/2017"
    }
  }
}

extension MatchStage {
  var inkableArea: Int {
    switch self {
    case .anchoVGames: return 2642
    case .arowanaMall: return 2391
    case .blackbellySkatepark: return 2583
    case .campTriggerfish: return 2338
    case .gobyArena: return 2221
    case .humpbackPumpTrack: return 2248
    case .inkblotArtAcademy: return 2468
    case .kelpDome: return 2147
    case .makoMart: return 2167
    case .mantaMaria: return 2356
    // #10
    case .morayTowers: return 2212
    case .musselforgeFitness: return 1958
    case .newAlbacoreHotel: return 2405
    case .piranhaPit: return 3081
    case .portMackerel: return 2457
    case .shellendorfInstitute: return 2052
    case .shiftyStation: return 2011
    case .skipperPavilion: return 2439
    case .snapperCanal: return 2247
    case .starfishMainstage: return 2320
    // #20
    case .sturgeonShipyard: return 2356
    case .theReef: return 2908
    case .wahooWorld: return 2858
    case .walleyeWarehouse: return 1632
    }
  }
}

extension MatchStage {
  var imgFiln: String { rawValue.replacingOccurrences(of: " ", with: "_") }
  var imgFilnLarge: String { imgFiln + "_large" }
}
