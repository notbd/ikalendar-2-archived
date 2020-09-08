//
//  SelectedModeEnv.swift
//  ikalendar2
//
//  Created by Tianwei Zhang on 9/7/20.
//  Copyright © 2020 Tianwei Zhang. All rights reserved.
//

import Foundation

final class SelectedModeEnv: ObservableObject {
    @Published var selectedMode = UserDefaults.standard.integer(forKey: Constants.USERDEFAULTS_KEY_DEFAULTMODE_INT)
}
