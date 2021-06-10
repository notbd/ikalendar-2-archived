//
//  BattleRotationListView.swift
//  ikalendar2
//
//  Created by Tianwei Zhang on 3/26/21.
//

import SwiftUI

// MARK: - BattleRotationListView

/// The view that displays a list of battle rotations.
struct BattleRotationListView: View {
  @EnvironmentObject var ikaCatalog: IkaCatalog
  @EnvironmentObject var ikaStatus: IkaStatus
  @EnvironmentObject var ikaTimer: IkaTimer

  var battleRotations: [BattleRotation] {
    let rawRotations = ikaCatalog.battleRotations[ikaStatus.battleModeSelection]!
    func filterCurrent<T: Rotation>(rotation: T) -> Bool {
      !rotation.isExpired(currentTime: ikaTimer.currentTime)
    }
    let results = rawRotations.filter(filterCurrent)
    return results
  }

  var body: some View {
    GeometryReader { geometry in
      Form {
        ForEach(Array(battleRotations.enumerated()),
                id: \.offset) { index, rotation in
          BattleRotationRow(rotation: rotation,
                            index: index,
                            width: geometry.size.width)
        }
      }
      .disabled(ikaCatalog.loadingStatus != .loaded)
    }
  }
}

// MARK: - BattleRotationListView_Previews

struct BattleRotationListView_Previews: PreviewProvider {
  static var previews: some View {
    BattleRotationListView()
      .environmentObject(IkaCatalog())
  }
}
