//
//  MatchRotationListView.swift
//  ikalendar2
//
//  Created by Tianwei Zhang on 3/26/21.
//

import SwiftUI

// MARK: - MatchRotationListView

/// The view that displays a list of match rotations.
struct MatchRotationListView: View {
  @EnvironmentObject var ikaCatalog: IkaCatalog
  @EnvironmentObject var ikaStatus: IkaStatus
  @EnvironmentObject var ikaTimer: IkaTimer

  var matchRotations: [MatchRotation] {
    let rawRotations = ikaCatalog.matchRotations[ikaStatus.matchModeSelection]!
    func filterCurrent<T: Rotation>(rotation: T) -> Bool {
      !rotation.isExpired(currentTime: ikaTimer.currentTime)
    }
    let results = rawRotations.filter(filterCurrent)
    return results
  }

  var body: some View {
    GeometryReader { geometry in
      List {
        ForEach(Array(matchRotations.enumerated()),
                id: \.offset) { index, rotation in
            MatchRotationRow(rotation: rotation,
                             index: index,
                             width: geometry.size.width)
        }
      }
      .disabled(ikaCatalog.loadingStatus != .loaded)
      .listStyle(InsetGroupedListStyle())
    }
  }
}

// MARK: - MatchRotationListView_Previews

struct MatchRotationListView_Previews: PreviewProvider {
  static var previews: some View {
    MatchRotationListView()
      .environmentObject(IkaCatalog())
  }
}
