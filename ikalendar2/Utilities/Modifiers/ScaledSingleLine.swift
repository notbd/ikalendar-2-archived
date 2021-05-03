//
//  ScaledSingleLine.swift
//  ikalendar2
//
//  Created by Tianwei Zhang on 3/28/21.
//

import SwiftUI

extension View {
  /// A modifier that limits the text to a limited lines
  /// and automatically scales down if needed.
  ///
  /// - Parameters:
  ///   - lineLimit: The max number of lines (default to 1).
  ///   - minScaleFactor: The minimum scale factor of the text (default to Constants config).
  /// - Returns: The modified view.
  func scaledLimitedLine(
    lineLimit: Int = 1,
    minScaleFactor: CGFloat = Constants.Styles.Global.MIN_TEXT_SCALE_FACTOR)
    -> some View
  {
    modifier(ScaledLimitedLine(lineLimit: lineLimit,
                               minScaleFactor: minScaleFactor))
  }
}

// MARK: - ScaledLimitedLine

struct ScaledLimitedLine: ViewModifier {
  var lineLimit: Int
  var minScaleFactor: CGFloat

  // MARK: Internal

  func body(content: Content) -> some View {
    content
      .lineLimit(lineLimit)
      .minimumScaleFactor(minScaleFactor)
  }
}
