//
//  MotionManager.swift
//  ikalendar2
//
//  Created by Tianwei Zhang on 4/15/21.
//

import CoreMotion
import SwiftUI

/// A CoreMotion manager class to broadcast device motions.
class MotionManager: ObservableObject {
  private let motionManager = CMMotionManager()

  var xs: [CGFloat] = []
  var ys: [CGFloat] = []
  var zs: [CGFloat] = []

  var dx: CGFloat = 0
  var dy: CGFloat = 0
  var dz: CGFloat = 0

  // MARK: Lifecycle

  init() {
    let cycle = 10.0
    let interval = 0.1
    var arrayCapacity: Int { Int(cycle / interval) }

    motionManager.deviceMotionUpdateInterval = interval

    motionManager.startDeviceMotionUpdates(to: .main) { [self] data, _ in
      guard let newData = data?.gravity else { return }

      // Make sure the arrays contain `cycle` seconds of data at most
      if xs.count > arrayCapacity { xs.removeFirst() }
      if ys.count > arrayCapacity { ys.removeFirst() }
      if zs.count > arrayCapacity { zs.removeFirst() }

      xs.append(CGFloat(newData.x))
      ys.append(CGFloat(newData.y))
      zs.append(CGFloat(newData.z))

      // Calculate the difference between current value and array average
      self.dx = CGFloat(newData.x) - xs.reduce(0, +) / CGFloat(xs.count)
      self.dy = CGFloat(newData.y) - ys.reduce(0, +) / CGFloat(ys.count)
      self.dz = CGFloat(newData.z) - zs.reduce(0, +) / CGFloat(zs.count)

      // Send change
      self.objectWillChange.send()
    }
  }

  // MARK: Internal

  func shutdown() {
    motionManager.stopDeviceMotionUpdates()
  }
}
