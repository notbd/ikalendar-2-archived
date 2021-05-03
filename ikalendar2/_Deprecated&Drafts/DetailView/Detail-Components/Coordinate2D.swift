//
//  Coordinate2D.swift
//  ikalendar2
//
//  Created by Tianwei Zhang on 4/17/21.
//

import Foundation

/// A struct for helper function to build a 2D coordinate.
struct Coordinate2D {
  /// Get a random latitude value in UIUC.
  /// - Returns: The latitude value in double.
  static func getRandomLatitude() -> Double {
    Double.random(in: 40.098349 ..< 40.114950)
  }

  /// Get a random longitude value in UIUC.
  /// - Returns: The longitude value in double.
  static func getRandomLongitude() -> Double {
    Double.random(in: -88.240958 ..< -88.224244)
  }
}
