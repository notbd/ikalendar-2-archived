//
//  SilhouetteFrame.swift
//  ikalendar2
//
//  Created by Tianwei Zhang on 3/27/21.
//

import SwiftUI

extension View {
  /// A modifier function that adds a subdued background to the view.
  ///
  /// - Parameters:
  ///   - cornerRadius: The corner radius of the background frame.
  ///   - silhouetteColor: The color scheme of the silhouette.
  /// - Returns: The modified view.
  func silhouetteFrame(
    cornerRadius: CGFloat,
    colorScheme silhouetteColor: SilhouetteFrame.SilhouetteColorScheme = .regular)
  -> some View {
    modifier(SilhouetteFrame(cornerRadius: cornerRadius,
                             silhouetteColor: silhouetteColor))
  }
}

// MARK: - SilhouetteFrame

struct SilhouetteFrame: ViewModifier {
  @Environment(\.colorScheme) private var colorScheme

  typealias Scoped = Constants.Styles.Frame

  var cornerRadius: CGFloat
  var silhouetteColor: SilhouetteColorScheme

  enum SilhouetteColorScheme {
    case regular
    case inverted
    case dark
    case light
  }

  var blurStyle: UIBlurEffect.Style {
    let lightStyle: UIBlurEffect.Style = .systemThinMaterialLight
    let darkStyle: UIBlurEffect.Style = .systemThinMaterialDark

    switch silhouetteColor {
    case .regular:

      switch colorScheme {
      case .dark:
        return darkStyle
      case .light:
        return lightStyle
      @unknown default:
        return darkStyle
      }

    case .inverted:
      switch colorScheme {
      case .dark:
        return lightStyle
      case .light:
        return darkStyle
      @unknown default:
        return lightStyle
      }

    case .dark:
      return darkStyle

    case .light:
      return lightStyle
    }
  }

  // MARK: Internal

  func body(content: Content) -> some View {
    content
      .background(Blur(style: blurStyle))
      .cornerRadius(cornerRadius)
  }
}
