//
//  RootView.swift
//  ikalendar2
//
//  Created by Tianwei Zhang on 4/15/21.
//

import SwiftUI

/// The entry view of the app.
/// Provide an interface for some upfront View-level configurations.
struct RootView: View {
  @Environment(\.colorScheme) var deviceColorScheme
  @EnvironmentObject var ikaStatus: IkaStatus
  @EnvironmentObject var ikaPreference: IkaPreference

  var body: some View {
    MainView()
      .preferredColorScheme(ikaPreference.appColorScheme.systemValue)
      .fullScreenCover(isPresented: $ikaStatus.isSettingsPresented) {
        SettingsMainView()
          .environmentObject(ikaStatus)
          .environmentObject(ikaPreference)
          .accentColor(.orange)
          .preferredColorScheme(ikaPreference.appColorScheme.systemValue)
      }
  }
}
