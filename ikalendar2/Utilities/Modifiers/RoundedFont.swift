//
//  RoundedFont.swift
//  ikalendar2
//
//  Created by Peter Zhang on 6/9/21.
//  Copyright © 2021 Tianwei Zhang. All rights reserved.
//

import SwiftUI

extension View {
  /// A modifier function that quickly applies a rounded font design to the text.
  ///
  /// - Parameters:
  ///   - size: The size of the font.
  ///   - weight: The weight of the font.
  /// - Returns: The modified view.
  func roundedFont(size: CGFloat, weight: Font.Weight)
  -> some View {
    modifier(RoundedFontSize(size: size,
                             weight: weight))
  }

  /// A modifier function that quickly applies a rounded font design to the text.
  ///
  /// - Parameters:
  ///   - textStyle: The text style of the font. Default to `.body`.
  /// - Returns: The modified view.
  func roundedFont(textStyle: Font.TextStyle = .body)
  -> some View {
    modifier(RoundedFontTextStyle(textStyle: textStyle))
  }
}

// MARK: - RoundedFontSize

struct RoundedFontSize: ViewModifier {
  var size: CGFloat
  var weight: Font.Weight

  func body(content: Content) -> some View {
    content
      .font(.system(size: size,
                    weight: weight,
                    design: .rounded))
  }
}

// MARK: - RoundedFontTextStyle

struct RoundedFontTextStyle: ViewModifier {
  var textStyle: Font.TextStyle

  func body(content: Content) -> some View {
    content
      .font(.system(textStyle,
                    design: .rounded))
  }
}
