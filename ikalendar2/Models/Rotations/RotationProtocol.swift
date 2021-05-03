//
//  RotationProtocol.swift
//  ikalendar2
//
//  Created by Tianwei Zhang on 3/31/21.
//

import Foundation

// MARK: - Rotation

/// Protocol for the rotation
protocol Rotation {
  var id: String { get }
  var startTime: Date { get }
  var endTime: Date { get }
  func isCurrent(currentTime: Date) -> Bool
}

extension Rotation {
  /// Check if rotation is coming next according to the current time.
  /// - Parameter currentTime: The current time.
  /// - Returns: The boolean val.
  func isCurrent(currentTime: Date) -> Bool {
    currentTime > startTime && currentTime < endTime
  }

  /// Check if rotation is expired according to the current time.
  /// - Parameter currentTime: The current time.
  /// - Returns: The boolean val.
  func isExpired(currentTime: Date) -> Bool {
    endTime < currentTime
  }
}
