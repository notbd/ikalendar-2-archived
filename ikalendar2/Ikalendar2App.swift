//
//  ikalendar2App.swift
//  ikalendar2
//
//  Created by Tianwei Zhang on 3/23/21.
//

import SwiftUI

/// Main Application Entry.
@main
struct Ikalendar2App: App {
  var ikaCatalog = IkaCatalog()
  var ikaStatus: IkaStatus
  var ikaTimer = IkaTimer()
  var ikaPreference: IkaPreference
  var motionManager = MotionManager()

  var body: some Scene {
    WindowGroup {
      RootView()
        .environmentObject(ikaCatalog)
        .environmentObject(ikaStatus)
        .environmentObject(ikaTimer)
        .environmentObject(ikaPreference)
        .environmentObject(motionManager)
        .accentColor(.secondary)
    }
  }

  // MARK: Lifecycle

  init() {
    UIKitIntegration.customizeNavigationTitleText()
    UIKitIntegration.customizePickerText()
    UserDefaults.standard.register(defaults: [Constants.Keys.AppStorage.DEFAULT_GAME_MODE: "match"])
    UserDefaults.standard
      .register(defaults: [Constants.Keys.AppStorage.DEFAULT_MATCH_MODE: "gachi"])
    ikaPreference = IkaPreference()
    ikaStatus = IkaStatus()
  }
}
