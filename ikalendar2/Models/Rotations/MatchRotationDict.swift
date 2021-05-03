//
//  MatchRotationDict.swift
//  ikalendar2
//
//  Created by Tianwei Zhang on 4/14/21.
//

import Foundation

typealias MatchRotationDict = [MatchMode: [MatchRotation]]
extension MatchRotationDict {
  var numOfRounds: Int {
    self[.gachi]!.count
  }

  // MARK: Lifecycle

  init() {
    self = [
      .regular: [] as [MatchRotation],
      .gachi: [] as [MatchRotation],
      .league: [] as [MatchRotation],
    ]
  }

  // MARK: Internal

  /// Check if any match mode has an empty array.
  /// - Returns: The boolean val.
  func isEmpty() -> Bool {
    self[.regular]!.isEmpty || self[.gachi]!.isEmpty || self[.league]!.isEmpty
  }

  /// Check if the dict needs to refresh.
  /// - Parameter currentTime: The current time.
  /// - Returns: The boolean val.
  func doesNeedToRefresh(currentTime: Date) -> Bool {
    currentTime > self[.gachi]![0].endTime
  }
}
