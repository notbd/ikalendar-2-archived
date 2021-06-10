//
//  SettingsMainView.swift
//  ikalendar2
//
//  Created by Tianwei Zhang on 4/15/21.
//

import SwiftUI

// MARK: - SettingsMainView

/// The main page for App Settings.
struct SettingsMainView: View {
  @EnvironmentObject var ikaStatus: IkaStatus
  @EnvironmentObject var ikaPreference: IkaPreference
  @Environment(\.openURL) var openURL

  private var currLanguage: String {
    if Locale.current.identifier.starts(with: "en") { return "English" }
    if Locale.current.identifier.starts(with: "ja") { return "日本語" }
    if Locale.current.identifier.starts(with: "zh_Hans") { return "简体中文(beta)" }
    if Locale.current.identifier.starts(with: "zh_Hant") { return "繁體中文(beta)" }
    else { return "Unknown" }
  }

  var body: some View {
    NavigationView {
      Form {
        Section(header: Text("Default Mode")) {
          rowDefaultGameMode
          rowDefaultBattleMode
        }

        Section(header: Text("Appearance")) {
          rowColorScheme
          rowShuffleImages
          rowAppIcon
        }

        Section(header: Text("Language")) {
          rowAppLanguage
        }

        Section {
          rowAbout
          rowAcknowledgement
        }
      }
      .roundedFont()
      .navigationTitle("Settings")
      .navigationBarItems(trailing: doneButton)
    }
    .navigationViewStyle(StackNavigationViewStyle())
  }

  // MARK: - Components ↓↓↓

  // MARK: - Default Mode Section

  private var rowDefaultGameMode: some View {
    HStack {
      Image(systemName: "rectangle.topthird.inset")
        .foregroundColor(.accentColor)

      Spacer().frame(width: 50)

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
    }
  }

  private var rowDefaultBattleMode: some View {
    HStack {
      Image(systemName: "rectangle.bottomthird.inset.fill")
        .foregroundColor(.accentColor)

      Spacer().frame(width: 50)

      Picker(selection: $ikaPreference.defaultBattleMode.onSet { _ in
        Haptics.generate(.selection)
      },
      label: Text("Default Battle Mode")) {
        ForEach(BattleMode.allCases) { battleMode in
          Text(battleMode.shortName.localizedStringKey())
            .tag(battleMode)
        }
      }
      .pickerStyle(SegmentedPickerStyle())
      .disabled(ikaPreference.defaultGameMode != .battle)
    }
  }

  // MARK: - Appearance Section

  private var rowColorScheme: some View {
    HStack {
      Label("Color Scheme",
            systemImage: "circle.lefthalf.fill")

      Spacer().frame(maxWidth: 50)

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
  }

  private var rowShuffleImages: some View {
    Toggle(isOn: .constant(true)) {
      Label("Shuffle Cover Images",
            systemImage: "shuffle")
    }
    .toggleStyle(SwitchToggleStyle(tint: .accentColor))
  }

  private var rowAppIcon: some View {
    NavigationLink(destination: SettingsAppIconView()) {
      Label("App Icon",
            systemImage: "square.stack")
    }
  }

  // MARK: - Language Section

  private var rowAppLanguage: some View {
    Button {
      Haptics.generate(.selection)
      if let url = URL(string: UIApplication.openSettingsURLString) {
        openURL(url)
      }
    } label: {
      HStack {
        Label(title: {
                Text("App Language").foregroundColor(.primary)
              },
              icon: {
                Image(systemName: "globe")
              })
        Spacer()
        Text(currLanguage).foregroundColor(.secondary)
        Image(systemName: "arrow.up.forward.app.fill").foregroundColor(.secondary)
      }
    }
  }

  // MARK: - Others Section

  private var rowAbout: some View {
    NavigationLink(destination: SettingsAboutView()) {
      Label("About",
            systemImage: "house.fill")
    }
  }

  private var rowAcknowledgement: some View {
    NavigationLink(destination: SettingsAcknowledgementView()) {
      Label("Acknowledgement",
            systemImage: "bookmark")
    }
  }

  // MARK: - Toolbar Buttons

  private var doneButton: some View {
    Button {
      Haptics.generate(.selection)
      ikaStatus.isSettingsPresented.toggle()
    } label: {
      Text("Done")
        .fontWeight(.semibold)
    }
  }
}

// MARK: - SettingsMainView_Previews

struct SettingsMainView_Previews: PreviewProvider {
  static var previews: some View {
    SettingsMainView()
  }
}
