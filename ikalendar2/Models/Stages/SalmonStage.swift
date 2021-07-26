//
//  SalmonStage.swift
//  ikalendar2
//
//  Created by Tianwei Zhang on 4/2/21.
//

// MARK: - SalmonStage

/// Data model for the salmon run stages.
enum SalmonStage: Int, Identifiable, CaseIterable {
  case spawningGrounds = 5000
  case maroonerSBay = 5001
  case lostOutpost = 5002
  case salmonidSmokeyard = 5003
  case ruinsOfArkPolaris = 5004

  var id: Int { rawValue }
}

/// Failable SalmonStage initializer using Stage Name.
extension SalmonStage {
  init?(name: String) {
    switch name {
    case "Spawning Grounds":
      self = .spawningGrounds
    case "Marooner's Bay":
      self = .maroonerSBay
    case "Lost Outpost":
      self = .lostOutpost
    case "Salmonid Smokeyard":
      self = .salmonidSmokeyard
    case "Ruins of Ark Polaris":
      self = .ruinsOfArkPolaris
    default:
      return nil
    }
  }
}

extension SalmonStage {
  var name: String {
    switch self {
    case .spawningGrounds:
      return "Spawning Grounds"
    case .maroonerSBay:
      return "Marooner's Bay"
    case .lostOutpost:
      return "Lost Outpost"
    case .salmonidSmokeyard:
      return "Salmonid Smokeyard"
    case .ruinsOfArkPolaris:
      return "Ruins of Ark Polaris"
    }
  }
}

extension SalmonStage {
  var imgFiln: String {
    name
      .replacingOccurrences(of: " ", with: "_")
      .replacingOccurrences(of: "'", with: "_")
  }

//  var imgFilnSmall: String { imgFiln + "_small" }
}
