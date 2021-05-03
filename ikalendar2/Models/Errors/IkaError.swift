//
//  IkaError.swift
//  ikalendar2
//
//  Created by Tianwei Zhang on 4/1/21.
//

// MARK: - IkaError

/// A custom error type for the app.
enum IkaError: Error {
  typealias Scoped = Constants.Keys.Error

  case unableToComplete
  case invalidResponse
  case invalidData
  case unknownError
}

extension IkaError {
  var title: String {
    switch self {
    case .unableToComplete:
      return Scoped.Title.UNABLE_TO_COMPLETE
    case .invalidResponse:
      return Scoped.Title.INVALID_RESPONSE
    case .invalidData:
      return Scoped.Title.INVALID_DATA
    case .unknownError:
      return Scoped.Title.UNKNOWN_ERROR
    }
  }
}

extension IkaError {
  var message: String {
    switch self {
    case .unableToComplete:
      return Scoped.Message.UNABLE_TO_COMPLETE
    case .invalidResponse:
      return Scoped.Message.INVALID_RESPONSE
    case .invalidData:
      return Scoped.Message.INVALID_DATA
    case .unknownError:
      return Scoped.Message.UNKNOWN_ERROR
    }
  }
}
