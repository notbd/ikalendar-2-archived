//
//  KeyConstants.swift
//  ikalendar2
//
//  Created by Tianwei Zhang on 3/27/21.
//
import Foundation

/// Constant data holding `keys` for the app.
extension Constants.Keys {
  static let appName = Bundle.main.infoDictionary?["CFBundleName"]
    as? String ?? "UNKNOWN"
  static let appVersion = Bundle.main.infoDictionary?["CFBundleShortVersionString"]
    as? String ?? "Unknown"
  static let appBuildNumber = Bundle.main.infoDictionary?["CFBundleVersion"]
    as? String ?? "unknown"

  enum AppStorage {
    static let COLOR_SCHEME = "PREF_COLOR_SCHEME"
    static let DEFAULT_GAME_MODE = "DEFAULT_GAME_MODE"
    static let DEFAULT_BATTLE_MODE = "DEFAULT_BATTLE_MODE"
  }

  enum URL {
    static let BATTLE_ROTATIONS = "https://splatoon2.ink/data/schedules.json"
    static let OATMEALDOME = "https://files.oatmealdome.me/bcat/coop.json"
    static let SALMON_ROTATIONS = "https://splatoon2.ink/data/coop-schedules.json"
    static let TIMELINE = "https://splatoon2.ink/data/timeline.json"

    static let NINTENDO_SPLATOON2_PAGE = "https://splatoon.nintendo.com/"
    static let DEVELOPER_TWITTER = "https://twitter.com/gppppa_"
    static let DEVELOPER_EMAIL = "mailto:zhang13music@outlook.com"
    static let APP_STORE_PAGE = "https://apps.apple.com/app/id1529193361"
    static let APP_STORE_PAGE_US = "https://apps.apple.com/us/app/ikalendar2/id1529193361"
    static let APP_STORE_REVIEW = "https://apps.apple.com/app/id1529193361?action=write-review"
    static let SOURCE_CODE_REPO = "https://github.com/zhang13music/ikalendar-2"
    static let PRIVACY_POLICY = "https://github.com/zhang13music/ikalendar-2/wiki/Privacy-Policy"
  }

  enum Error {
    enum Title {
      static let UNABLE_TO_COMPLETE = "Connection Error"
      static let INVALID_RESPONSE = "Server Error"
      static let INVALID_DATA = "Server Error"
      static let UNKNOWN_ERROR = "Unknown Error"
    }

    enum Message {
      static let UNABLE_TO_COMPLETE =
        """
        Cannot connect to the server.
        Please check your interenet connection and tap the mode icon to refresh.
        """
      static let INVALID_RESPONSE =
        """
        Invalid response from the server.
        If this persists, please contact support.
        """
      static let INVALID_DATA =
        """
        The data received from the server was invalid.
        Please try again later or contact support.
        """
      static let UNKNOWN_ERROR =
        """
        Ooops...
        An unknown error was encountered ¯\\_(ツ)_/¯
        """
    }
  }
}
