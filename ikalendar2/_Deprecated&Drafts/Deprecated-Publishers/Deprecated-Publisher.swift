//
//  Deprecated-Publisher.swift
//  ikalendar2
//
//  Created by Tianwei Zhang on 4/11/21.
//

import Combine
import Foundation

/// [DEPRECATED]
/// This class was deprecated because combining publishers and await all data tasks is
/// more elegant than using individual callbacks.
/// [USE IKAPUBLISHER() INSTEAD]
final class DeprecatedIkaPublisher {
  static let shared = DeprecatedIkaPublisher()

  private var requests = Set<AnyCancellable>()

  // MARK: Lifecycle

  private init() {}

  // MARK: Internal

  func asyncFetchMatchRotationDict(
    errorHandler: @escaping (IkaError) -> Void,
    valueHandler: @escaping (MatchRotationDict) -> Void)
  {
    let url = URL(string: Constants.Keys.URL.MATCH_ROTATIONS)!
    asyncFetchAndDecode(url: url,
                        decodeUsing: IkaDecoder.parseMatchRotationDict,
                        errorHandler: errorHandler,
                        valueHandler: valueHandler)
  }

  func asyncFetchSalmonRotationArray(
    errorHandler: @escaping (IkaError) -> Void,
    valueHandler: @escaping ([SalmonRotation]) -> Void)
  {
    let url = URL(string: Constants.Keys.URL.SALMON_ROTATIONS)!
    asyncFetchAndDecode(url: url,
                        decodeUsing: IkaDecoder.parseSalmonRotationArray,
                        errorHandler: errorHandler,
                        valueHandler: valueHandler)
  }

  func asyncFetchRewardGear(
    errorHandler: @escaping (IkaError) -> Void,
    valueHandler: @escaping (SalmonGear) -> Void)
  {
    let url = URL(string: Constants.Keys.URL.TIMELINE)!
    asyncFetchAndDecode(url: url,
                        decodeUsing: IkaDecoder.parseRewardGear,
                        errorHandler: errorHandler,
                        valueHandler: valueHandler)
  }

  // MARK: Private

  private func asyncFetchAndDecode<T>(
    url: URL,
    decodeUsing decoder: @escaping (Data) throws -> T,
    errorHandler: @escaping (IkaError) -> Void,
    valueHandler: @escaping (T) -> Void)
  {
    URLSession.shared.dataTaskPublisher(for: url)
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
      .receive(on: DispatchQueue.main)
      .sink(receiveCompletion: { completion in
        switch completion {
        case let .failure(error):
          switch error {
          case let ikaError as IkaError:
            errorHandler(ikaError)
          default:
            errorHandler(IkaError.unableToComplete)
          }
        case .finished:
          break
        }
      }, receiveValue: valueHandler)
      .store(in: &requests)
  }
}
