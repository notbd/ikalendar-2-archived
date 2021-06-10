//
//  IkaPublisher.swift
//  ikalendar2
//
//  Created by Tianwei Zhang on 4/11/21.
//

import Combine
import Foundation

/// A publisher manager class that handles network call with Swift `Combine` framework.
final class IkaPublisher {
  /// The shared singleton.
  static let shared = IkaPublisher()

  // MARK: Lifecycle

  private init() {}

  // MARK: Internal

  /// Get the publisher of the battle rotations from the `splatoon2.ink` api.
  /// - Returns: The generated publisher.
  func getBattleRotationDictPublisher() -> AnyPublisher<BattleRotationDict, IkaError> {
    let url = URL(string: Constants.Keys.URL.BATTLE_ROTATIONS)!
    return getPublisher(url: url,
                        decodeUsing: IkaDecoder.parseBattleRotationDict)
  }

  /// Get the publisher of the battle rotation dict from the `splatoon2.ink` api.
  /// - Returns: The generated publisher.
  func getSalmonRotationArrayPublisher() -> AnyPublisher<[SalmonRotation], IkaError> {
    let url = URL(string: Constants.Keys.URL.SALMON_ROTATIONS)!
    return getPublisher(url: url,
                        decodeUsing: IkaDecoder.parseSalmonRotationArray)
  }

  /// Get the publisher of the reward gear from the `splatoon2.ink` api.
  /// - Returns: The generated publisher.
  func getRewardGearPublisher() -> AnyPublisher<SalmonGear, IkaError> {
    let url = URL(string: Constants.Keys.URL.TIMELINE)!
    return getPublisher(url: url,
                        decodeUsing: IkaDecoder.parseRewardGear)
  }

  // MARK: Private

  /// Generate a publisher for the data that was fetched from the api and decoded by the decoder.
  /// - Parameters:
  ///   - url: The url to fetch data from.
  ///   - decoder: The decoder function to transform the raw data.
  /// - Returns: The publisher of the decoded data.
  private func getPublisher<T>(
    url: URL,
    decodeUsing decoder: @escaping (Data) throws -> T)
  -> AnyPublisher<T, IkaError> {
    URLSession.shared.dataTaskPublisher(for: url) // Publisher<(Data, URLResponse), Error>
      .retry(1)
      .tryMap { data, response in
        guard
          let response = response as? HTTPURLResponse,
          [200, 304].contains(response.statusCode)
        else {
          // FAILED: empty or invalid response
          throw IkaError.invalidResponse
        }

        do {
          // decoding...
          let decoded = try decoder(data)
          // SUCCESS!
          return decoded
        } catch {
          // FAILED: bad data
          throw IkaError.invalidData
        }
      }
      .mapError { error in
        switch error {
        case is URLError:
          return .unableToComplete
        case let ikaError as IkaError:
          return ikaError
        default:
          return .unknownError
        }
      }
      .receive(on: DispatchQueue.main)
      .eraseToAnyPublisher()
  }
}
