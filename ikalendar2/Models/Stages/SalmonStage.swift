//
//  SalmonStage.swift
//  ikalendar2
//
//  Created by Tianwei Zhang on 4/2/21.
//

// MARK: - SalmonStage

/// Data model for the salmon run stages.
enum SalmonStage: String, Identifiable, CaseIterable {
  case lostOutpost = "Lost Outpost"
  case maroonerSBay = "Marooner's Bay"
  case ruinsOfArkPolaris = "Ruins of Ark Polaris"
  case salmonidSmokeyard = "Salmonid Smokeyard"
  case spawningGrounds = "Spawning Grounds"

  var id: String { rawValue }
}

extension SalmonStage {
  var name: String { rawValue }
}

extension SalmonStage {
  var imgFiln: String {
    rawValue
      .replacingOccurrences(of: " ", with: "_")
      .replacingOccurrences(of: "'", with: "_")
  }

//  var imgFilnSmall: String { imgFiln + "_small" }
}
