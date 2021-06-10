//
//  SettingsAcknowledgementView.swift
//  ikalendar2
//
//  Created by Peter Zhang on 6/7/21.
//  Copyright © 2021 Tianwei Zhang. All rights reserved.
//

import SwiftUI

// MARK: - SettingsAcknowledgementView

/// The Acknowledgement page in App Settings.
struct SettingsAcknowledgementView: View {
  @Environment(\.openURL) var openURL

  var body: some View {
    Form {}
      .navigationTitle("Acknowledgement")
      .navigationBarTitleDisplayMode(.inline)
  }
}

// MARK: - SettingsAcknowledgementView_Previews

struct SettingsAcknowledgementView_Previews: PreviewProvider {
  static var previews: some View {
    SettingsAcknowledgementView()
  }
}
