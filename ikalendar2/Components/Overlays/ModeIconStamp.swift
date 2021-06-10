//
//  ModeIconStamp.swift
//  ikalendar2
//
//  Created by Tianwei Zhang on 4/14/21.
//

import SwiftUI

// MARK: - ModeIconStamp

/// A mode icon overlay of the ContentView.
struct ModeIconStamp: View {
  @EnvironmentObject var ikaCatalog: IkaCatalog
  @EnvironmentObject var ikaStatus: IkaStatus
  @EnvironmentObject var motion: MotionManager

  var x: CGFloat { motion.dx }
  var y: CGFloat { motion.dy }
  var rot: Double { Double((pow(x, 2) + pow(y, 2)).squareRoot()) }
  var degrees: Double = 22

  var body: some View {
    icon
      .rotationEffect(.degrees(8))
      .rotation3DEffect(.degrees(degrees * rot), axis: (x: y, y: x, z: 0))
      .offset(x: -10, y: -90)
      .opacity(ikaCatalog.loadingStatus == .loaded ? 1 : 0)
      .animation(.easeOut(duration: Constants.Styles.Global.ANIMATION_DURATION))
  }

  var gradientMask: some View {
    // mask color does not matter; only opacity matters
    let maskColor = Color(UIColor.systemBackground)
    return LinearGradient(gradient: Gradient(colors: [
      maskColor.opacity(1),
      maskColor.opacity(0.95),
      maskColor.opacity(0.9),
      maskColor.opacity(0.85),
      maskColor.opacity(0.8),
      maskColor.opacity(0.6),
      maskColor.opacity(0.5),
      maskColor.opacity(0.2),
      maskColor.opacity(0.08),
      maskColor.opacity(0.02),
      maskColor.opacity(0),
    ]),
    startPoint: .top,
    endPoint: .bottom)
  }

  var icon: some View {
    let imgFiln: String
    switch ikaStatus.gameModeSelection {
    case .battle:
      imgFiln = ikaStatus.battleModeSelection.imgFilnLarge
    case .salmon:
      imgFiln = "grizz"
    }

    return
      Image(imgFiln)
      .antialiased(true)
      .resizable()
      .scaledToFit()
      .mask(gradientMask)
      .frame(width: 128, height: 128)
  }
}

// MARK: - FlatModeIconStamp_Previews

struct FlatModeIconStamp_Previews: PreviewProvider {
  static var previews: some View {
    ModeIconStamp()
  }
}
