//
//  TappableAreaFrame.swift
//  ikalendar2
//
//  Created by Tianwei Zhang on 3/27/21.
//

import SwiftUI

extension View {
  /// A modifier function that wraps the view in a tappable sized frame.
  ///
  /// - Returns: The modified view.
  func tappableAreaFrame() -> some View {
    modifier(TappableAreaFrame())
  }
}

// MARK: - TappableAreaFrame

struct TappableAreaFrame: ViewModifier {
  func body(content: Content) -> some View {
    content
      .frame(width: Constants.Styles.Frame.MIN_TAPPABLE_AREA_SIDE,
             height: Constants.Styles.Frame.MIN_TAPPABLE_AREA_SIDE)
  }
}
