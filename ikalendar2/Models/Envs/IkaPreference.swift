//
//  IkaPreference.swift
//  ikalendar2
//
//  Created by Tianwei Zhang on 4/15/21.
//

import Combine
import SwiftUI

/// An EnvObj class that is shared among all the views.
/// Contains the app preferences.
final class IkaPreference: ObservableObject {
  /*
   Default Modes: Init value already set by UserDefaults, so init value here does not matter.
   */
  @AppStorage(Constants.Keys.AppStorage.DEFAULT_GAME_MODE)
  var defaultGameMode: GameMode = .battle { willSet { objectWillChange.send() }}

  @AppStorage(Constants.Keys.AppStorage.DEFAULT_BATTLE_MODE)
  var defaultBattleMode: BattleMode = .regular { willSet { objectWillChange.send() }}

  /*
   Color Scheme
   */
  @AppStorage(Constants.Keys.AppStorage.COLOR_SCHEME)
  var appColorScheme: AppColorScheme = .dark { willSet { objectWillChange.send() }}

  enum AppColorScheme: String, Identifiable, CaseIterable {
    case dark
    case light

    var id: String { rawValue }

    var name: String {
      switch self {
      case .dark:
        return "Dark"
      case .light:
        return "Light"
      }
    }

    var systemValue: ColorScheme {
      switch self {
      case .dark:
        return .dark
      case .light:
        return .light
      }
    }
  }
}
