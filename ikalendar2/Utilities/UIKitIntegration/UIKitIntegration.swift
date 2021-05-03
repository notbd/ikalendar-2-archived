//
//  UIKitIntegration.swift
//  ikalendar2
//
//  Created by Tianwei Zhang on 3/24/21.
//

import UIKit

class UIKitIntegration {
  /// Customize the navigation title text.
  static func customizeNavigationTitleText() {
    // MARK: - Set NavBar Font to SF Pro Rounded

    let largeTitleFontSize: CGFloat = 33
    let titleTextFontSize: CGFloat = 18

    // Here we get San Francisco with the desired weight
    let systemLargeTitleFont = UIFont.systemFont(ofSize: largeTitleFontSize, weight: .bold)
    let systemTitleTextFont = UIFont.systemFont(ofSize: titleTextFontSize, weight: .semibold)

    // Will be SF Pro in case of failure.
    let largeTitleFont, titleTextFont: UIFont

    if let descriptor = systemLargeTitleFont.fontDescriptor.withDesign(.rounded) {
      largeTitleFont = UIFont(descriptor: descriptor, size: largeTitleFontSize)
    } else {
      largeTitleFont = systemLargeTitleFont
    }

    if let descriptor = systemTitleTextFont.fontDescriptor.withDesign(.rounded) {
      titleTextFont = UIFont(descriptor: descriptor, size: titleTextFontSize)
    } else {
      titleTextFont = systemTitleTextFont
    }

    UINavigationBar.appearance().largeTitleTextAttributes = [.font: largeTitleFont]
    UINavigationBar.appearance().titleTextAttributes = [.font: titleTextFont]
  }

  /// Customize the picker text.
  static func customizePickerText() {
    // MARK: - Config Segment Picker Text Style

    let pickerFontSize: CGFloat = 13

    let systemPickerSelectedFont = UIFont.systemFont(ofSize: 14, weight: .semibold)
    let systemPickerNormalFont = UIFont.systemFont(ofSize: 14, weight: .regular)

    let pickerSelectedFont, pickerNormalFont: UIFont

    if let descriptor = systemPickerSelectedFont.fontDescriptor.withDesign(.rounded) {
      pickerSelectedFont = UIFont(descriptor: descriptor, size: pickerFontSize)
    } else {
      pickerSelectedFont = systemPickerSelectedFont
    }

    if let descriptor = systemPickerNormalFont.fontDescriptor.withDesign(.rounded) {
      pickerNormalFont = UIFont(descriptor: descriptor, size: pickerFontSize)
    } else {
      pickerNormalFont = systemPickerNormalFont
    }

    UISegmentedControl.appearance()
      .setTitleTextAttributes([NSAttributedString.Key.font: pickerSelectedFont],
                              for: .selected)
    UISegmentedControl.appearance()
      .setTitleTextAttributes([NSAttributedString.Key.font: pickerNormalFont],
                              for: .normal)
  }
}
