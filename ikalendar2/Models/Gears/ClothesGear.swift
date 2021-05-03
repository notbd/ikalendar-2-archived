//
//  ClothesGear.swift
//  ikalendar2
//
//  Created by Tianwei Zhang on 4/7/21.
//

// MARK: - ClothesGear

/// Data model for the clothes gears.
enum ClothesGear: Int, Identifiable, CaseIterable {
  case squiddorPolo = 21000
  case anchorLifeVest = 21001
  case juiceParka = 21002
  case gardenGear = 21003
  case crustwearXXL = 21004
  case northCountryParka = 21005
  case recordShopLookEP = 21007
  case devUniform = 21008
  case officeAttire = 21009
  case srlCoat = 21010

  var id: Int { rawValue }
}

extension ClothesGear {
  var name: String {
    switch self {
    case .squiddorPolo: return "Squiddor Polo"
    case .anchorLifeVest: return "Anchor Life Vest"
    case .juiceParka: return "Juice Parka"
    case .gardenGear: return "Garden Gear"
    case .crustwearXXL: return "Crustwear XXL"
    case .northCountryParka: return "North-Country Parka"
    case .recordShopLookEP: return "Record Shop Look EP"
    case .devUniform: return "Dev Uniform"
    case .officeAttire: return "Office Attire"
    case .srlCoat: return "SRL Coat"
    }
  }
}

extension ClothesGear {
  var key: String {
    switch self {
    case .squiddorPolo: return "Clt_COP100"
    case .anchorLifeVest: return "Clt_COP101"
    case .juiceParka: return "Clt_COP102"
    case .gardenGear: return "Clt_COP103"
    case .crustwearXXL: return "Clt_COP104"
    case .northCountryParka: return "Clt_COP105"
    case .recordShopLookEP: return "Clt_COP107"
    case .devUniform: return "Clt_COP108"
    case .officeAttire: return "Clt_COP109"
    case .srlCoat: return "Clt_COP110"
    }
  }
}

extension ClothesGear {
  var imgFiln: String {
    let prefix = "S2_Gear_Clothing_"
    let content = name.replacingOccurrences(of: " ", with: "_")
    return prefix + content
  }

  var imgFilnSmall: String { key }
}
