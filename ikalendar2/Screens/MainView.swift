//
//  MainView.swift
//  ikalendar2
//
//  Created by Tianwei Zhang on 3/30/21.
//

import SwiftUI

// MARK: - MainView

/// The main view of the app.
/// Will set different layout for iPhone and iPad depending on the current horizontal size.
struct MainView: View {
  @Environment(\.horizontalSizeClass) private var horizontalSizeClass

  var body: some View {
    NavigationView {
      if horizontalSizeClass == .compact {
        ContentView()
      } else {
        ContentView()
      }
    }
  }
}

// MARK: - MainView_Previews

struct MainView_Previews: PreviewProvider {
  static var previews: some View {
    MainView()
  }
}
