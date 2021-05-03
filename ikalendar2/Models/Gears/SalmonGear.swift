//
//  SalmonGear.swift
//  ikalendar2
//
//  Created by Tianwei Zhang on 4/4/21.
//

// MARK: - SalmonGear

/// Data model for the salmon run reward gears.
enum SalmonGear {
  case clothes(ClothesGear)
  case shoes(ShoesGear)
  case head(HeadGear)

  enum GearType {
    case clothes
    case shoes
    case head
  }
}

extension SalmonGear {
  init?(type: GearType, id: Int) {
    switch type {
    case .clothes:
      guard let gear = ClothesGear(rawValue: id) else {
        return nil
      }
      self = .clothes(gear)
    case .shoes:
      guard let gear = ShoesGear(rawValue: id) else {
        return nil
      }
      self = .shoes(gear)
    case .head:
      guard let gear = HeadGear(rawValue: id) else {
        return nil
      }
      self = .head(gear)
    }
  }
}

extension SalmonGear {
  var name: String {
    switch self {
    case let .clothes(gear):
      return gear.name
    case let .shoes(gear):
      return gear.name
    case let .head(gear):
      return gear.name
    }
  }

  var key: String {
    switch self {
    case let .clothes(gear):
      return gear.key
    case let .shoes(gear):
      return gear.key
    case let .head(gear):
      return gear.key
    }
  }

  var imgFiln: String {
    switch self {
    case let .clothes(gear):
      return gear.imgFiln
    case let .shoes(gear):
      return gear.imgFiln
    case let .head(gear):
      return gear.imgFiln
    }
  }

  var imgFilnSmall: String {
    switch self {
    case let .clothes(gear):
      return gear.imgFilnSmall
    case let .shoes(gear):
      return gear.imgFilnSmall
    case let .head(gear):
      return gear.imgFilnSmall
    }
  }
}
