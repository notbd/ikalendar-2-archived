//
//  MatchRotationStageCard.swift
//  ikalendar2
//
//  Created by Tianwei Zhang on 3/28/21.
//

import SwiftUI

// MARK: - MatchRotationStageCardPrimary

/// The primary version of a card component that displays
/// the stage information of a match rotation.
struct MatchRotationStageCardPrimary: View {
  typealias Scoped = Constants.Styles.Rotation.Match.Card.Primary

  var stage: MatchStage

  var body: some View {
    Image(stage.imgFilnLarge)
      .antialiased(true)
      .resizable()
      .scaledToFit()
      .cornerRadius(Scoped.IMG_CORNER_RADIUS)
      .shadow(radius: Constants.Styles.Global.SHADOW_RADIUS)
      .overlay(StageTitleLabel(title: stage.name,
                               fontSize: Scoped.LABEL_FONT_SIZE)
          .padding(.leading, Scoped.LABEL_PADDING_LEADING)
          .padding(.bottom, Scoped.LABEL_PADDING_BOTTOMTRAILING)
          .padding(.trailing, Scoped.LABEL_PADDING_BOTTOMTRAILING),
        alignment: .bottomTrailing)
  }
}

// MARK: - MatchRotationStageCardSecondary

/// The secondary version of a card component that displays
/// the stage information of a match rotation.
struct MatchRotationStageCardSecondary: View {
  typealias Scoped = Constants.Styles.Rotation.Match.Card.Secondary

  var stage: MatchStage

  var body: some View {
    VStack(alignment: .trailing) {
      Image(stage.imgFilnLarge)
        .resizable()
        .scaledToFit()
        .cornerRadius(Scoped.IMG_CORNER_RADIUS)
        .shadow(radius: Constants.Styles.Global.SHADOW_RADIUS)
        .offset(y: Scoped.STAGE_IMG_OFFSET_Y)

      Text(stage.name.localizedStringKey())
        .scaledLimitedLine()
        .fontIka(.ika2, size: Scoped.FONT_SIZE)
    }
  }
}

// MARK: - MatchRotationStageCard_Previews

struct MatchRotationStageCard_Previews: PreviewProvider {
  static var previews: some View {
    MatchRotationStageCardPrimary(stage: .theReef)
      .previewLayout(.fixed(width: 320, height: 200))
    MatchRotationStageCardSecondary(stage: .humpbackPumpTrack)
      .previewLayout(.fixed(width: 300, height: 240))
  }
}
