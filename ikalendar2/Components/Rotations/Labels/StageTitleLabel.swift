//
//  StageTitleLabel.swift
//  ikalendar2
//
//  Created by Tianwei Zhang on 3/28/21.
//

import SwiftUI

// MARK: - StageTitleLabel

/// A label overlay displaying the title of the stage.
struct StageTitleLabel: View {
  typealias Scoped = Constants.Styles.Rotation.Label

  let title: String
  let fontSize: CGFloat
  var avoidBlur: Bool = false

  var body: some View {
    // Use ZStack instead of silhouette to enable offset adjustment
    ZStack {
      if avoidBlur {
        Rectangle()
          .foregroundColor(.black)
          .opacity(0.7)
          .cornerRadius(Scoped.BACKGROUND_CORNER_RADIUS)
      } else {
        Blur(style: .systemChromeMaterialDark)
          .cornerRadius(Scoped.BACKGROUND_CORNER_RADIUS)
      }

      Text(title.localizedStringKey())
        .scaledLimitedLine()
        .fontIka(.ika2, size: fontSize)
        .foregroundColor(.white)
        .padding(.horizontal, Scoped.TEXT_PADDING_HORIZONTAL)
        .offset(y: Scoped.TEXT_OFFSET_Y)
    }
    .fixedSize()
  }
}

// MARK: - StageTitleLabel_Previews

struct StageTitleLabel_Previews: PreviewProvider {
  static var previews: some View {
    StageTitleLabel(title: BattleStage.humpbackPumpTrack.name,
                    fontSize: 12)
  }
}
