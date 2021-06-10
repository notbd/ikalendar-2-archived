//
//  IkaCatalog.swift
//  ikalendar2
//
//  Created by Tianwei Zhang on 3/31/21.
//

import Combine
import SwiftUI

/// An EnvObj class that is shared among all the views.
/// Contains the rotation data and its loading status.
final class IkaCatalog: ObservableObject {
  @Published var battleRotations = BattleRotationDict()
  @Published var salmonRotations = [SalmonRotation]()

  enum LoadingStatus: Equatable {
    case loading
    case loaded
    case error(IkaError)
  }

  @Published var loadingStatus = LoadingStatus.loading
  @Published var loadedVSErrorStatus = LoadingStatus.loading

  enum AutoLoadingStatus: Equatable {
    case autoLoading
    case autoLoaded(AutoLoadedStatus)
    case idle

    enum AutoLoadedStatus {
      case success
      case failure
    }
  }

  @Published var autoLoadingStatus = AutoLoadingStatus.idle

  private var protectedCancellables = Set<AnyCancellable>()
  private var dataTaskCancellables = Set<AnyCancellable>()

  private var loadedVSErrorPublisher: AnyPublisher<LoadingStatus, Never> {
    $loadingStatus
      .removeDuplicates()
      .filter { ikaError in
        switch ikaError {
        case .error,
             .loaded:
          return true
        default:
          return false
        }
      }
      .eraseToAnyPublisher()
  }

  private let autoRefreshPublisher = Timer.publish(every: 2,
                                                   tolerance: 0.2,
                                                   on: .main,
                                                   in: .common).autoconnect()

  // MARK: Lifecycle

  init() {
    // set up publishers
    setUpLoadedVSErrorPublisher()
    setUpAutoLoadPublisher()

    // load first set of data
    loadCatalog()
  }

  // MARK: Internal

  // MARK: - Status Marking

  /// Mark the `loadingStatus` as `.loading`
  func markAsLoading() {
    DispatchQueue.main.async {
      Haptics.generate(.selection)
      self.loadingStatus = .loading
    }
  }

  /// Mark the `loadingStatus` as `.loaded`
  func markAsLoaded() {
    DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
      Haptics.generate(.success)
      self.loadingStatus = .loaded
    }
  }

  /// Mark the `loadingStatus` as `.error`
  /// - Parameter error: The IkaError error type.
  func markAsError(error: IkaError) {
    DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
      Haptics.generate(.error)
      self.loadingStatus = .error(error)
    }
  }

  /// Mark the `autoLoadingStatus` as `.autoLoading`
  func markAsAutoLoading() {
    DispatchQueue.main.async {
      self.autoLoadingStatus = .autoLoading
    }
  }

  /// Mark the `autoLoadingStatus` as `.autoLoaded`
  /// then mark it as `.idle` after a while.
  /// - Parameter status: The autoloaded status.
  func markAsAutoLoaded(status: AutoLoadingStatus.AutoLoadedStatus) {
    DispatchQueue.main.async {
      Haptics.generate(.selection)
      self.autoLoadingStatus = .autoLoaded(status)
    }
    DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
      self.cancelAutoLoadingStatus()
    }
  }

  /// Mark the `autoLoadingStatus` as `.idle`
  func cancelAutoLoadingStatus() {
    DispatchQueue.main.async {
      self.autoLoadingStatus = .idle
    }
  }

  // MARK: - Set Up Publishers

  /// Set up the publisher that checks to see if needs to start autoloading the catalog.
  func setUpAutoLoadPublisher() {
    autoRefreshPublisher
      .receive(on: DispatchQueue.main)
      .sink { currentTime in
        guard
          !self.battleRotations.isEmpty,
          self.loadingStatus != .loading,
          self.autoLoadingStatus != .autoLoading
        else { return }

        if self.battleRotations.doesNeedToRefresh(currentTime: currentTime) {
          self.autoLoadBattleRotations()
        }
      }
      .store(in: &protectedCancellables)
  }

  /// Set up the publisher that publishes change if loadingStatus is
  /// switched `TO` `loaded` or `.error`
  func setUpLoadedVSErrorPublisher() {
    loadedVSErrorPublisher
      .receive(on: DispatchQueue.main)
      .assign(to: \.loadedVSErrorStatus, on: self)
      .store(in: &protectedCancellables)
  }

  // MARK: - Basic Loading & Refreshing

  /// Refresh the catalog once.
  func refreshCatalog() {
    markAsLoading()
    loadCatalog()
  }

  /// Load the catalog and set corresponding current loading status.
  func loadCatalog() {
    let battleRotationDictPublisher = IkaPublisher.shared.getBattleRotationDictPublisher()
    let salmonRotationArrayPublisher = IkaPublisher.shared.getSalmonRotationArrayPublisher()
    let rewardGearPublisher = IkaPublisher.shared.getRewardGearPublisher()

    let combinedPublisher = Publishers.Zip3(battleRotationDictPublisher,
                                            salmonRotationArrayPublisher,
                                            rewardGearPublisher)
    combinedPublisher
      .receive(on: DispatchQueue.main)
      .sink { completion in
        switch completion {
        case let .failure(ikaError):
          self.markAsError(error: ikaError)
        case .finished:
          self.markAsLoaded()
          self.cancelAutoLoadingStatus()
          self.dataTaskCancellables.removeAll()
        }
      } receiveValue: { battleRotations, salmonRotations, rewardGear in
        DispatchQueue.main.async {
          self.battleRotations = battleRotations
          self.salmonRotations = salmonRotations
          self.salmonRotations[0].rewardGear = rewardGear
        }
      }
      .store(in: &dataTaskCancellables)
  }

  // MARK: - Auto Refreshing

  /// Start autoloading the battle rotations.
  func autoLoadBattleRotations() {
    let maxAttempts = 8
    var currAttempts = 0
    let attemptPublisher = Timer.publish(every: 2,
                                         tolerance: 0.2,
                                         on: .main,
                                         in: .common).autoconnect()
    markAsAutoLoading()
    attemptPublisher
      .receive(on: DispatchQueue.main)
      .sink { _ in
        guard currAttempts < maxAttempts
        else {
          // exceeds max num of attempts: Silently drops the autoload
          self.markAsAutoLoaded(status: .failure)
          // stop data tasks
          self.dataTaskCancellables.removeAll()
          return
        }

        currAttempts += 1
        let battleRotationDictPublisher = IkaPublisher.shared.getBattleRotationDictPublisher()
        battleRotationDictPublisher
          .receive(on: DispatchQueue.main)
          .sink { completion in
            switch completion {
            case let .failure(ikaError):
              self.markAsError(error: ikaError)
              self.markAsAutoLoaded(status: .failure)
            case .finished:
              break
            }
          } receiveValue: { battleRotations in
            // duplicate: skip
            guard battleRotations != self.battleRotations
            else { return }

            // new rotation data: set
            DispatchQueue.main.async {
              self.battleRotations = battleRotations
            }
            self.markAsAutoLoaded(status: .success)

            // stop attempting
            self.dataTaskCancellables.removeAll()
          }
          .store(in: &self.dataTaskCancellables)
      }
      .store(in: &dataTaskCancellables)
  }
}
