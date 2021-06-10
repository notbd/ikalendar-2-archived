//
//  BattleRotation.swift
//  ikalendar2
//
//  Created by Tianwei Zhang on 3/27/21.
//

import Foundation

/// Data model for the battle rotation.
struct BattleRotation: Rotation, Identifiable, Equatable {
  var id: String {
    "\(startTime.timeIntervalSince1970)-\(rule.name)"
  }

  let startTime: Date
  let endTime: Date

  let rule: BattleRule
  let stageA: BattleStage
  let stageB: BattleStage

  // MARK: Internal

  /// The equal comparison operator for the SalmonRotation struct.
  /// - Parameters:
  ///   - lhs: The left hand side.
  ///   - rhs: The right hand side.
  /// - Returns: The comparison result.
  static func == (lhs: BattleRotation, rhs: BattleRotation) -> Bool {
    lhs.id == rhs.id
  }

  /// Check if rotation is coming next according to the current time.
  /// - Parameter currentTime: The current time.
  /// - Returns: The boolean val.
  func isNext(currentTime: Date) -> Bool {
    let twoHoursLater = Calendar.current.date(byAdding: .hour,
                                              value: 2,
                                              to: currentTime)!
    return twoHoursLater > startTime && twoHoursLater < endTime
  }
}
