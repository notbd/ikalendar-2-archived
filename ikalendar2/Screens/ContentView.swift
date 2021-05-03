//
//  ContentView.swift
//  ikalendar2
//
//  Created by Tianwei Zhang on 3/23/21.
//

import SwiftUI

// MARK: - ContentView

/// The view that displays the content in a NavigationView.
struct ContentView: View {
  @Environment(\.horizontalSizeClass) private var horizontalSizeClass
  var isHorizontalCompact: Bool { horizontalSizeClass == .compact }

  @EnvironmentObject var ikaCatalog: IkaCatalog
  @EnvironmentObject var ikaStatus: IkaStatus

  var body: some View {
    ZStack {
      content
        .if(isHorizontalCompact) {
          setCompactHoriClassToolbar(content: $0)
        } else: {
          setRegularHoriClassToolbar(content: $0)
        }
        .navigationTitle(title)
        .overlay(ModeIconStamp(),
                 alignment: .topTrailing)
          .overlay(AutoLoadingOverlay(autoLoadingStatus: ikaCatalog.autoLoadingStatus),
                   alignment: .bottomTrailing)

      // MARK: loading overlay

      LoadingOverlay(loadingStatus: ikaCatalog.loadingStatus)
    }
  }

  var content: some View {
    Group {
      switch ikaCatalog.loadedVSErrorStatus {
      // For better visual: not switch content during loading
      case let .error(ikaError):
        ErrorView(error: ikaError)
      case .loaded:
        switch ikaStatus.gameModeSelection {
        case .match:
          MatchRotationListView()
        case .salmon:
          SalmonRotationListView()
        }
      default:
        Spacer()
      }
    }
  }

  var title: LocalizedStringKey {
    switch ikaStatus.gameModeSelection {
    case .match:
      return ikaStatus.matchModeSelection.name.localizedStringKey()
    case .salmon:
      return ikaStatus.gameModeSelection.name.localizedStringKey()
    }
  }

  // MARK: Internal

  func setCompactHoriClassToolbar<Content: View>(content: Content) -> some View {
    content
      .toolbar {
        // MARK: refresh button

        ToolbarItem(placement: .navigationBarLeading) {
          ToolbarRefreshButton(alignment: .leading,
                               isDisabled: ikaCatalog.loadingStatus == .loading,
                               action: didTapRefreshButton)
        }

        ToolbarItem(placement: .navigationBarTrailing) {
          ToolbarSettingsButton(alignment: .trailing,
                                action: didTapSettingsButton)
        }

        ToolbarItemGroup(placement: .bottomBar) {
          // MARK: game mode button

          ToolbarGameModeSwitchButton()

          Spacer()

          if ikaStatus.gameModeSelection == .match {
            // MARK: match mode picker

            ToolbarMatchModePicker()
          }
        }
      }
  }

  func setRegularHoriClassToolbar<Content: View>(content: Content) -> some View {
    content
      .toolbar {
        // MARK: refresh button

        ToolbarItem(placement: .navigationBarLeading) {
          ToolbarRefreshButton(alignment: .leading,
                               isDisabled: ikaCatalog.loadingStatus == .loading,
                               action: didTapRefreshButton)
        }
      }
  }

  func didTapRefreshButton() {
    ikaCatalog.refreshCatalog()
  }

  func didTapSettingsButton() {
    Haptics.generate(.selection)
    ikaStatus.isSettingsPresented.toggle()
  }
}

// MARK: - ToolbarMatchModePicker

/// A picker component for the match mode
struct ToolbarMatchModePicker: View {
  @EnvironmentObject var ikaStatus: IkaStatus

  var body: some View {
    Picker(selection: $ikaStatus.matchModeSelection.onSet { _ in
      Haptics.generate(.soft)
    },
    label: Text("Match Mode")) {
        ForEach(MatchMode.allCases) { matchMode in
          Text(matchMode.shortName.localizedStringKey())
            .tag(matchMode)
        }
    }
    .pickerStyle(SegmentedPickerStyle())
  }
}

// MARK: - ContentView_Previews

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
      .environmentObject(IkaCatalog())
  }
}
