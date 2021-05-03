//
//  SimpleHaptics.swift
//
//  Created by Tianwei Zhang on 4/2/21.
//

import UIKit

/// Generates haptics on supported devices.
///
/// Will silently fail if unsupported on the device,
/// so compatibility check could be skipped.
public enum Haptics {
  /// Types of different haptics.
  ///
  /// Selection Haptic - is used to give user feedback when a selection changes.
  /// - `selection`: Generates a gentle tap to the user indicating a selection has changed.
  ///
  /// Notification Haptic - is used to give user feedback when an notification is displayed.
  /// - `success`: Indicates an action completed successfully to the user.
  /// - `warning`: Indicates to the user that a warning has occurred, or that something is about to happen.
  /// - `error`: Indicates an error has occurred to the user.
  ///
  /// Impact Haptic - is used to give user feedback when an impact between UI elements occurs.
  /// - `light`: A light impact. Slightly stronger than HapticType.selection
  /// - `medium`: An impact stronger than HapticType.light
  /// - `heavy`: An impact stronger than HapticType.medium
  /// - `soft`: A soft impact.
  /// - `rigid`: A rigid impact.
  public enum HapticType {
    case selection

    case success
    case warning
    case error

    case light
    case medium
    case heavy
    case soft
    case rigid
  }

  // swiftlint:disable:next cyclomatic_complexity
  /// Generates a haptic feedback.
  ///
  /// It is safe to call this function on any version of iOS without checking availability.
  /// On devices that don't support the specified haptic type, this function silently fails.
  ///
  /// - Parameter hapticType: The type of haptics to generate.
  /// Notice that the soft impact and rigid impact are only supported since iOS 13.
  public static func generate(_ hapticType: HapticType) {
    guard #available(iOS 10.0, *) else { return }

    DispatchQueue.main.async {
      switch hapticType {
      case .selection:
        UISelectionFeedbackGenerator().selectionChanged()

      case .success:
        UINotificationFeedbackGenerator().notificationOccurred(.success)

      case .warning:
        UINotificationFeedbackGenerator().notificationOccurred(.warning)

      case .error:
        UINotificationFeedbackGenerator().notificationOccurred(.error)

      case .light:
        UIImpactFeedbackGenerator(style: .light).impactOccurred()

      case .medium:
        UIImpactFeedbackGenerator(style: .medium).impactOccurred()

      case .heavy:
        UIImpactFeedbackGenerator(style: .heavy).impactOccurred()

      case .soft:
        guard #available(iOS 13.0, *) else { return }
        UIImpactFeedbackGenerator(style: .soft).impactOccurred()

      case .rigid:
        guard #available(iOS 13.0, *) else { return }
        UIImpactFeedbackGenerator(style: .rigid).impactOccurred()
      }
    }
  }
}
