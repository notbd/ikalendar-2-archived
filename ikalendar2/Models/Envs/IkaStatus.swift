//
//  IkaStatus.swift
//  ikalendar2
//
//  Created by Tianwei Zhang on 4/9/21.
//

import Combine
import SwiftUI

/// An EnvObj class that is shared among all the views.
/// Contains the app status.
final class IkaStatus: ObservableObject {
  @Published var isSettingsPresented = false

  @Published var gameModeSelection = GameMode(rawValue: UserDefaults.standard
    .string(forKey: Constants.Keys.AppStorage.DEFAULT_GAME_MODE)!)!
  @Published var matchModeSelection = MatchMode(rawValue: UserDefaults.standard
    .string(forKey: Constants.Keys.AppStorage.DEFAULT_MATCH_MODE)!)!
}
