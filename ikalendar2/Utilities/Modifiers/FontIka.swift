//
//  FontIka.swift
//  ikalendar2
//
//  Created by Tianwei Zhang on 3/28/21.
//

import SwiftUI

extension View {
  /// A modifier function that quickly applies a custom ika font to the view.
  ///
  /// - Parameters:
  ///   - ikaFont: The type of the ika font.
  ///   - size: The size of the ika font.
  /// - Returns: The modified view.
  func fontIka(
    _ ikaFont: IkaFont,
    size: CGFloat)
  -> some View {
    modifier(FontIka(ikaFont: ikaFont,
                     size: size))
  }

  /// A modifier function that quickly applies a custom ika font to the view.
  ///
  /// - Parameters:
  ///   - ikaFont: The type of the ika font.
  ///   - size: The size of the ika font.
  ///   - textStyle: The text style that this size is relative to.
  /// - Returns: The modified view.
  func fontIka(
    _ ikaFont: IkaFont,
    size: CGFloat,
    relativeTo textStyle: Font.TextStyle)
  -> some View {
    modifier(FontIkaDynamic(ikaFont: ikaFont,
                            size: size,
                            textStyle: textStyle))
  }
}

// MARK: - IkaFont

enum IkaFont: String {
  case ika1 = "Splatfont"
  case ika2 = "Splatfont2"
}

// MARK: - FontIka

struct FontIka: ViewModifier {
  var ikaFont: IkaFont
  var size: CGFloat

  func body(content: Content) -> some View {
    content
      .font(.custom(ikaFont.rawValue,
                    size: size))
  }
}

// MARK: - FontIkaDynamic

struct FontIkaDynamic: ViewModifier {
  var ikaFont: IkaFont
  var size: CGFloat
  var textStyle: Font.TextStyle

  func body(content: Content) -> some View {
    content
      .font(.custom(ikaFont.rawValue,
                    size: size,
                    relativeTo: textStyle))
  }
}
