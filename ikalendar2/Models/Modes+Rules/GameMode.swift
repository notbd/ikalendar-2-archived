//
//  GameMode.swift
//  ikalendar2
//
//  Created by Tianwei Zhang on 3/31/21.
//

// MARK: - GameMode

/// Data model for the game modes.
enum GameMode: String, Identifiable, CaseIterable, Equatable {
  case battle
  case salmon

  var id: String { rawValue }
}

extension GameMode {
  var name: String {
    switch self {
    case .battle: return "Battle"
    case .salmon: return "Salmon Run"
    }
  }

  var shortName: String {
    switch self {
    case .battle: return "Battle"
    case .salmon: return "Salmon"
    }
  }
}

extension GameMode {
  var sfSymbolIdle: String {
    switch self {
    case .battle: return "flag"
    case .salmon: return "lifepreserver"
    }
  }
}

extension GameMode {
  var sfSymbolSelected: String {
    switch self {
    case .battle: return "flag.fill"
    case .salmon: return "lifepreserver.fill"
    }
  }
}
