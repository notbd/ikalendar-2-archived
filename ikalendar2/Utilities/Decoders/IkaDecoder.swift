//
//  IkaDecoder.swift
//  ikalendar2
//
//  Created by Tianwei Zhang on 4/1/21.
//

import Foundation

/// A decoder class to parse the data got from the api
/// into our data model.
final class IkaDecoder {
  /// Parse the data into a battle rotation dictionary.
  /// - Parameter data: The data to parse from.
  /// - Throws:
  ///   - `SwiftyJSONError`: if failed to parse data into a SwiftyJSON instance.
  ///   - `IkaError.invalidData`: if JSON is in of unsupported format.
  /// - Returns: The parsed dictionary (will NOT be empty).
  static func parseBattleRotationDict(from data: Data) throws -> BattleRotationDict {
    var battleRotationDict = BattleRotationDict()

    // Will throw SwiftyJSONError if parsing fails
    let rootJSON = try JSON(data: data)

    for battleMode in BattleMode.allCases {
      // for all BattleModes:

      let battleModeString = battleMode.rawValue
      guard let rotationArrayJSON = rootJSON[battleModeString].array
      else {
        // ERROR: parse rotation array
        throw IkaError.invalidData
      }

      for rotationJSON in rotationArrayJSON {
        guard
          let startTimeDouble = rotationJSON["start_time"].double,
          let endTimeDouble = rotationJSON["end_time"].double,
          let ruleNameString = rotationJSON["rule"]["name"].string,
          let stageANameString = rotationJSON["stage_a"]["name"].string,
          let stageBNameString = rotationJSON["stage_b"]["name"].string
        else {
          // ERROR: rotation attributes of wrong type or structure
          throw IkaError.invalidData
        }

        let startTime = Date(timeIntervalSince1970: startTimeDouble)
        let endTime = Date(timeIntervalSince1970: endTimeDouble)

        guard
          let rule = BattleRule(rawValue: ruleNameString),
          let stageA = BattleStage(rawValue: stageANameString),
          let stageB = BattleStage(rawValue: stageBNameString)
        else {
          // ERROR: invalid rule or stage key
          throw IkaError.invalidData
        }

        // SUCCESS: construct rotation using parsed data and append to array in dict
        battleRotationDict[battleMode]!.append(.init(startTime: startTime,
                                                     endTime: endTime,
                                                     rule: rule,
                                                     stageA: stageA,
                                                     stageB: stageB))
      }

      if battleRotationDict[battleMode]!.isEmpty {
        // ERROR: empty data for a battle rule
        throw IkaError.invalidData
      }
    }

    // return the parsed dict
    return battleRotationDict
  }

  /// Parse the data into a salmon rotation array.
  /// - Parameter data: The data to parse from.
  /// - Throws:
  ///   - `SwiftyJSONError`: if failed to parse data into a SwiftyJSON instance.
  ///   - `IkaError.invalidData`: if JSON is of unsupported format.
  /// - Returns: The parsed array (will NOT be empty).
  static func parseSalmonRotationArray(from data: Data) throws -> [SalmonRotation] {
    var salmonRotations: [SalmonRotation] = []

    // Will throw SwiftyJSONError if parsing fails
    let rootJSON = try JSON(data: data)

    // Get detailed rotations from details array
    guard let detailsArrayJSON = rootJSON["details"].array
    else {
      // ERROR: parse details array
      throw IkaError.invalidData
    }

    for rotationDetailsJSON in detailsArrayJSON {
      guard
        let startTimeDouble = rotationDetailsJSON["start_time"].double,
        let endTimeDouble = rotationDetailsJSON["end_time"].double
      else {
        // ERROR: rotation time of wrong type or structure
        throw IkaError.invalidData
      }

      let startTime = Date(timeIntervalSince1970: startTimeDouble)
      let endTime = Date(timeIntervalSince1970: endTimeDouble)
      var stage: SalmonStage?
      var weapons: [SalmonWeapon]? = []

      if let stageNameString = rotationDetailsJSON["stage"]["name"].string {
        // Has proper stage value
        stage = SalmonStage(name: stageNameString)
      }

      if let weaponsArrayJSON = rotationDetailsJSON["weapons"].array {
        // Has weapons array
        for weaponJSON in weaponsArrayJSON {
          if
            let weaponIdString = weaponJSON["id"].string,
            let weaponIdInt = Int(weaponIdString),
            let weapon = SalmonWeapon(weaponIdInt)
          {
            // id is in int string format
            weapons?.append(weapon)
          } else if
            let weaponIdInt = weaponJSON["id"].int,
            let weapon = SalmonWeapon(weaponIdInt)
          {
            // id is in int number format
            weapons?.append(weapon)
          } else {
            // ERROR: bad weapon id
            throw IkaError.invalidData
          }
        }
      }

      if weapons?.isEmpty == true {
        // if empty array: set back to nil
        weapons = nil
      }

      // SUCCESS: construct rotation using parsed data and append to array
      salmonRotations.append(.init(startTime: startTime,
                                   endTime: endTime,
                                   stage: stage,
                                   weapons: weapons))
    }

    // Enforce detailed rotation else throw an error
    guard !salmonRotations.isEmpty
    else {
      // ERROR: empty detailed rotations
      throw IkaError.invalidData
    }

    // Get remaining rotations from schedules array
    guard let schedulesArrayJSON = rootJSON["schedules"].array
    else {
      // empty schedules array: just return the detailed ones
      return salmonRotations
    }

    for index in salmonRotations.count ..< schedulesArrayJSON.count {
      if
        let startTimeDouble = schedulesArrayJSON[index]["start_time"].double,
        let endTimeDouble = schedulesArrayJSON[index]["end_time"].double
      {
        // SUCCESS: construct rotation using parsed data and append to array
        let startTime = Date(timeIntervalSince1970: startTimeDouble)
        let endTime = Date(timeIntervalSince1970: endTimeDouble)
        salmonRotations.append(.init(startTime: startTime,
                                     endTime: endTime))
      }
    }

    // Return the rotation array
    return salmonRotations
  }

  /// Parse the data into a salmon run reward gear.
  /// - Parameter data: The data to parse from.
  /// - Throws:
  ///   - `SwiftyJSONError`: if failed to parse data into a SwiftyJSON instance.
  ///   - `IkaError.invalidData`: if JSON is of unsupported format.
  /// - Returns: The parsed SalmonGear.
  static func parseRewardGear(from data: Data) throws -> SalmonGear {
    // Will throw SwiftyJSONError if parsing fails
    let rootJSON = try JSON(data: data)

    // Get detailed rotations from details array
    let gearJSON = rootJSON["coop"]["reward_gear"]["gear"]
    guard let gearTypeString = gearJSON["kind"].string
    else {
      // ERROR: bad gear kind
      throw IkaError.invalidData
    }

    let gearIdInt: Int
    if let value = gearJSON["id"].int {
      gearIdInt = value
    } else if
      let gearIdString = gearJSON["id"].string,
      let value = Int(gearIdString)
    {
      gearIdInt = value
    } else {
      // ERROR: bad gear id
      throw IkaError.invalidData
    }

    // Find gear with type and id
    var rewardGearOptional: SalmonGear?
    switch gearTypeString {
    case "clothes":
      rewardGearOptional = SalmonGear(type: .clothes, id: gearIdInt)
    case "shoes":
      rewardGearOptional = SalmonGear(type: .shoes, id: gearIdInt)
    case "head":
      rewardGearOptional = SalmonGear(type: .head, id: gearIdInt)
    default:
      rewardGearOptional = nil
    }

    guard let rewardGear = rewardGearOptional
    else {
      // ERROR: gear of non-existing kind or non-existing id
      throw IkaError.invalidData
    }

    // SUCCESS: return the gear
    return rewardGear
  }

  // TODO: Parse Oatmealdome data
  static func parseOatmealdome(from data: Data) throws -> [SalmonRotation] {
    var salmonRotations: [SalmonRotation] = []

    // Will throw SwiftyJSONError if parsing fails
    let rootJSON = try JSON(data: data)

    // Get stage and weapon info from phases array
    guard let phasesJSON = rootJSON["Phases"].array
    else {
      // ERROR: parse details array
      throw IkaError.invalidData
    }

    for phaseJSON in phasesJSON {
      // get date strings
      guard
        let startTimeString = phaseJSON["StartDateTime"].string,
        let endTimeString = phaseJSON["EndDateTime"].string
      else {
        // ERROR: rotation time of wrong type or structure
        throw IkaError.invalidData
      }

      // Set up date formatter to format the date string
      let dateFormatterGMT0000 = ISO8601DateFormatter()

      // convert to date
      guard
        let startTime = dateFormatterGMT0000.date(from: startTimeString + "+0000"),
        let endTime = dateFormatterGMT0000.date(from: endTimeString + "+0000")
      else {
        // ERROR: rotation time of wrong type or structure
        throw IkaError.invalidData
      }

      var stage: SalmonStage?
      var weapons: [SalmonWeapon]? = []
      var grizzcoWeapon: GrizzcoWeapon?

      // get stage
      guard
        let stageId = phaseJSON["StageID"].int
      else {
        // ERROR: rotation time of wrong type or structure
        throw IkaError.invalidData
      }
      stage = SalmonStage(rawValue: stageId)

      // get weapons
      if let weaponIdArray = phaseJSON["WeaponSets"].array {
        // Has weapons array
        for weaponId in weaponIdArray {
          if
            let weaponIdInt = weaponId.int,
            let weapon = SalmonWeapon(weaponIdInt)
          {
            weapons?.append(weapon)
          } else {
            // ERROR: bad weapon id
            dump(salmonRotations)
            throw IkaError.unableToComplete
          }
        }
      }

      // if empty weapons: set back to nil
      if weapons?.isEmpty == true {
        weapons = nil
      }

      // get grizzco weapon id
      guard
        let grizzcoWeaponId = phaseJSON["RareWeaponID"].int
      else {
        // ERROR: rotation time of wrong type or structure
        throw IkaError.invalidData
      }
      grizzcoWeapon = GrizzcoWeapon(rawValue: grizzcoWeaponId)

      // SUCCESS: construct rotation using parsed data and append to array
      salmonRotations.append(.init(startTime: startTime,
                                   endTime: endTime,
                                   stage: stage,
                                   weapons: weapons,
                                   grizzcoWeapon: grizzcoWeapon))
    }

    // Enforce detailed rotation else throw an error
    guard !salmonRotations.isEmpty
    else {
      // ERROR: empty detailed rotations
      throw IkaError.invalidData
    }

    // TODO: Add reward gear

    return salmonRotations
  }
}
