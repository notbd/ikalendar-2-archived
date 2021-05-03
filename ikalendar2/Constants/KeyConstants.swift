//
//  KeyConstants.swift
//  ikalendar2
//
//  Created by Tianwei Zhang on 3/27/21.
//

/// Constant data holding `keys` for the app.
extension Constants.Keys {
  enum AppStorage {
    static let COLOR_SCHEME = "PREF_COLOR_SCHEME"
    static let DEFAULT_GAME_MODE = "DEFAULT_GAME_MODE"
    static let DEFAULT_MATCH_MODE = "DEFAULT_MATCH_MODE"
  }

  enum URL {
    static let MATCH_ROTATIONS = "https://splatoon2.ink/data/schedules.json"
    static let SALMON_ROTATIONS = "https://splatoon2.ink/data/coop-schedules.json"
    static let TIMELINE = "https://splatoon2.ink/data/timeline.json"

    static let NINTENDO_SPLATOON2_PAGE = "https://splatoon.nintendo.com/"
    static let REPO_PAGE = "https://github.com/zhang13music/ikalendar-2"
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
