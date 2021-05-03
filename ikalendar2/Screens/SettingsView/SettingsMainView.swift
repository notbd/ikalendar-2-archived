//
//  SettingsMainView.swift
//  ikalendar2
//
//  Created by Tianwei Zhang on 4/15/21.
//

import SwiftUI

// MARK: - SettingsMainView

/// The view that displays the app settings.
struct SettingsMainView: View {
  @EnvironmentObject var ikaStatus: IkaStatus
  @EnvironmentObject var ikaPreference: IkaPreference
  @Environment(\.openURL) var openURL

  var currLanguage: String {
    if Locale.current.identifier.starts(with: "en") { return "English" }
    if Locale.current.identifier.starts(with: "ja") { return "日本語" }
//    if Locale.current.identifier.starts(with: "zh_Hans") { return "简体中文(beta)" }
//    if Locale.current.identifier.starts(with: "zh_Hant") { return "繁體中文(beta)" }
    else { return "Unknown" }
  }

  var body: some View {
    NavigationView {
      List {
        Section(header:
          Text("DEFAULT MODE".localizedStringKey())) {
            Picker(selection: $ikaPreference.defaultGameMode.onSet { _ in
              Haptics.generate(.selection)
            },
            label: Text("Default Game Mode")) {
                ForEach(GameMode.allCases) { gameMode in
                  Text(gameMode.name.localizedStringKey())
                    .tag(gameMode)
                }
            }
            .pickerStyle(SegmentedPickerStyle())

            Picker(selection: $ikaPreference.defaultMatchMode.onSet { _ in
              Haptics.generate(.selection)
            },
            label: Text("Default Match Mode")) {
                ForEach(MatchMode.allCases) { matchMode in
                  Text(matchMode.shortName.localizedStringKey())
                    .tag(matchMode)
                }
            }
            .pickerStyle(SegmentedPickerStyle())
            .disabled(ikaPreference.defaultGameMode != .match)
        }

        Section(header:
          Text("APPEARANCE".localizedStringKey())) {
            Picker(selection: $ikaPreference.appColorScheme.onSet { _ in
              Haptics.generate(.selection)
            },
            label: Text("App Color Scheme")) {
                ForEach(IkaPreference.AppColorScheme.allCases) { appColorScheme in
                  Text(appColorScheme.name.localizedStringKey())
                    .tag(appColorScheme)
                }
            }
            .pickerStyle(SegmentedPickerStyle())
        }

        Section(header:
          Text("LANGUAGE".localizedStringKey())) {
            Button {
              Haptics.generate(.selection)
              if let url = URL(string: UIApplication.openSettingsURLString) {
                openURL(url)
              }
            } label: {
              HStack {
                Text("Preferred Language".localizedStringKey()).foregroundColor(.primary)
                Spacer()
                Text(currLanguage).foregroundColor(.secondary)
                Image(systemName: "arrow.up.forward.app.fill").foregroundColor(.secondary)
              }
            }
        }

        Section(header:
          Text("ACKNOWLEDGEMENT".localizedStringKey())) {
            Button {
              Haptics.generate(.selection)
              if let url = URL(string: Constants.Keys.URL.NINTENDO_SPLATOON2_PAGE) {
                openURL(url)
              }
            } label: {
              HStack {
                Text("Splatoon™ 2".localizedStringKey()).foregroundColor(.primary)
                Spacer()
                Text("Official Website".localizedStringKey()).foregroundColor(.secondary)
                Image(systemName: "globe").foregroundColor(.secondary)
              }
            }
        }

        Section(header:
          Text("ABOUT".localizedStringKey()),
          footer:
          Text("ABOUT FOOTNOTE".localizedStringKey())) {
            Button {
              Haptics.generate(.selection)
              if let url = URL(string: Constants.Keys.URL.REPO_PAGE) {
                openURL(url)
              }
            } label: {
              HStack {
                Text("Source Code Repo".localizedStringKey()).foregroundColor(.primary)
                Spacer()
                Text("GitHub").foregroundColor(.secondary)
              }
            }
        }
      }
      .listSeparatorStyle(.none)
      .listStyle(InsetGroupedListStyle())
      .navigationTitle("Settings".localizedStringKey())
      .navigationBarItems(trailing:
        Button {
          Haptics.generate(.selection)
          ikaStatus.isSettingsPresented.toggle()
        } label: {
          Text("Done".localizedStringKey())
            .fontWeight(.semibold)
        })
    }
    .navigationViewStyle(StackNavigationViewStyle())
  }
}

// MARK: - SettingsMainView_Previews

struct SettingsMainView_Previews: PreviewProvider {
  static var previews: some View {
    SettingsMainView()
  }
}
