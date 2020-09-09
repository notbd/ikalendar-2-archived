//
//  MyHaptics.swift
//  ikalendar2
//
//  Created by Tianwei Zhang on 9/8/20.
//  Copyright © 2020 Tianwei Zhang. All rights reserved.
//

import UIKit

func simpleHapticSuccess() {
    let generator = UINotificationFeedbackGenerator()
    generator.notificationOccurred(.success)
}

func simpleHapticError() {
    let generator = UINotificationFeedbackGenerator()
    generator.notificationOccurred(.error)
}

func simpleHapticWarning() {
    let generator = UINotificationFeedbackGenerator()
    generator.notificationOccurred(.warning)
}

func simpleHapticLight() {
    let impact = UIImpactFeedbackGenerator(style: .light)
    impact.impactOccurred()
}

func simpleHapticMedium() {
    let impact = UIImpactFeedbackGenerator(style: .medium)
    impact.impactOccurred()
}

func simpleHapticHeavy() {
    let impact = UIImpactFeedbackGenerator(style: .heavy)
    impact.impactOccurred()
}
