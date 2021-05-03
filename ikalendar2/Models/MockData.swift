//
//  MockData.swift
//  ikalendar2
//
//  Created by Tianwei Zhang on 3/27/21.
//

import Foundation

/// Struct providing mock data for testing purpose.
struct MockData {
  /// Generate a mock SalmonRotation data.
  /// - Parameters:
  ///   - rawStartTime: The raw start time (rotation will start at the next
  ///                       rounded hour of this time).
  ///   - hasStageAndWeapons: If the rotation has stage and weapon information.
  ///   - randomWeaponType: The type of random weapon for the rotation.
  /// - Returns: The SalmonRotation data.
  static func getSalmonRotation(
    rawStartTime: Date = Date(),
    hasStageAndWeapons: Bool = true,
    randomWeaponType: RandomWeapon? = nil)
    -> SalmonRotation
  {
    let startTime = rawStartTime.removeMinutes()!
    let endTime = Calendar.current.date(byAdding: .hour,
                                        value: 42,
                                        to: startTime)!

    var stage: SalmonStage?
    var weapons: [SalmonWeapon]?

    if hasStageAndWeapons {
      // Has stage and weapons
      stage = SalmonStage.allCases.randomElement()!
      weapons = []
      if randomWeaponType == nil {
        // No random weapons
        for _ in 0 ..< 4 {
          let randomIkaWeapon = IkaWeapon.allCases.randomElement()!
          weapons!.append(SalmonWeapon(randomIkaWeapon.id)!)
        }
      } else {
        // Has random weapons
        switch randomWeaponType! {
        case .green:
          // Green question mark
          for _ in 0 ..< 3 {
            let randomIkaWeapon = IkaWeapon.allCases.randomElement()!
            weapons!.append(SalmonWeapon(randomIkaWeapon.id)!)
          }
          let randomWeapon = RandomWeapon.green
          weapons!.append(SalmonWeapon(randomWeapon.id)!)
        case .gold:
          // Gold question mark
          for _ in 0 ..< 4 {
            let randomWeapon = RandomWeapon.gold
            weapons!.append(SalmonWeapon(randomWeapon.id)!)
          }
        }
      }
    }

    return SalmonRotation(startTime: startTime,
                          endTime: endTime,
                          stage: stage,
                          weapons: weapons)
  }

  /// Generate a mock SalmonRotation array data.
  /// - Returns: The loaded SalmonRotation array.
  static func getSalmonRotations() -> [SalmonRotation] {
    var salmonRotations: [SalmonRotation] = []
    var startTimeArray: [Date] = []
    for index in 0 ..< 5 {
      startTimeArray.append(Calendar.current.date(byAdding: .hour,
                                                  value: index * 48,
                                                  to: Date())!)
    }

    salmonRotations.append(getSalmonRotation(rawStartTime: startTimeArray[0],
                                             hasStageAndWeapons: true,
                                             randomWeaponType: nil))
    salmonRotations.append(getSalmonRotation(rawStartTime: startTimeArray[1],
                                             hasStageAndWeapons: true,
                                             randomWeaponType: .green))
    salmonRotations.append(getSalmonRotation(rawStartTime: startTimeArray[2],
                                             hasStageAndWeapons: false))
    salmonRotations.append(getSalmonRotation(rawStartTime: startTimeArray[3],
                                             hasStageAndWeapons: false))
    salmonRotations.append(getSalmonRotation(rawStartTime: startTimeArray[4],
                                             hasStageAndWeapons: false))

    return salmonRotations
  }

  /// Generate a mock MatchRotation data.
  /// - Parameters:
  ///   - rule: The rule of the rotation.
  ///   - rawStartTime: The raw start time (rotation will start at the next
  ///                       rounded hour of this time).
  /// - Returns: The MatchRotation data.
  static func getMatchRotation(
    rule: MatchRule,
    rawStartTime: Date = Date())
    -> MatchRotation
  {
    let startTime = rawStartTime.removeMinutes()!
    let endTime = Calendar.current.date(byAdding: .hour,
                                        value: 2,
                                        to: startTime)!

    func getRandomMatchStage() -> MatchStage {
      MatchStage.allCases.randomElement()!
    }

    return MatchRotation(startTime: startTime,
                         endTime: endTime,
                         rule: rule,
                         stageA: getRandomMatchStage(),
                         stageB: getRandomMatchStage())
  }

  /// Generate a mock MatchRotationDict data.
  /// - Returns: The loaded MatchRotationDict.
  static func getMatchRotations() -> MatchRotationDict {
    var matchRotationDict = MatchRotationDict()
    var startTimeArray: [Date] = []
    for index in 0 ..< 8 {
      startTimeArray.append(Calendar.current.date(byAdding: .hour,
                                                  value: index * 2,
                                                  to: Date())!)
    }

    matchRotationDict[.regular] = [
      getMatchRotation(rule: .turfWar, rawStartTime: startTimeArray[0]),
      getMatchRotation(rule: .turfWar, rawStartTime: startTimeArray[1]),
      getMatchRotation(rule: .turfWar, rawStartTime: startTimeArray[2]),
      getMatchRotation(rule: .turfWar, rawStartTime: startTimeArray[3]),
      getMatchRotation(rule: .turfWar, rawStartTime: startTimeArray[4]),
      getMatchRotation(rule: .turfWar, rawStartTime: startTimeArray[5]),
      getMatchRotation(rule: .turfWar, rawStartTime: startTimeArray[6]),
      getMatchRotation(rule: .turfWar, rawStartTime: startTimeArray[7]),
    ]

    matchRotationDict[.gachi] = [
      getMatchRotation(rule: .towerControl, rawStartTime: startTimeArray[0]),
      getMatchRotation(rule: .splatZones, rawStartTime: startTimeArray[1]),
      getMatchRotation(rule: .clamBlitz, rawStartTime: startTimeArray[2]),
      getMatchRotation(rule: .rainmaker, rawStartTime: startTimeArray[3]),
      getMatchRotation(rule: .towerControl, rawStartTime: startTimeArray[4]),
      getMatchRotation(rule: .splatZones, rawStartTime: startTimeArray[5]),
      getMatchRotation(rule: .clamBlitz, rawStartTime: startTimeArray[6]),
      getMatchRotation(rule: .rainmaker, rawStartTime: startTimeArray[7]),
    ]

    matchRotationDict[.league] =
      [
        getMatchRotation(rule: .rainmaker, rawStartTime: startTimeArray[0]),
        getMatchRotation(rule: .clamBlitz, rawStartTime: startTimeArray[1]),
        getMatchRotation(rule: .towerControl, rawStartTime: startTimeArray[2]),
        getMatchRotation(rule: .splatZones, rawStartTime: startTimeArray[3]),
        getMatchRotation(rule: .clamBlitz, rawStartTime: startTimeArray[4]),
        getMatchRotation(rule: .towerControl, rawStartTime: startTimeArray[5]),
        getMatchRotation(rule: .rainmaker, rawStartTime: startTimeArray[6]),
        getMatchRotation(rule: .splatZones, rawStartTime: startTimeArray[7]),
      ]

    return matchRotationDict
  }
}
