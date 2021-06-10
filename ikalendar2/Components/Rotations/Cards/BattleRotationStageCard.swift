//
//  BattleRotationStageCard.swift
//  ikalendar2
//
//  Created by Tianwei Zhang on 3/28/21.
//

import SwiftUI

// MARK: - BattleRotationStageCardPrimary

/// The primary version of a card component that displays
/// the stage information of a battle rotation.
struct BattleRotationStageCardPrimary: View {
  typealias Scoped = Constants.Styles.Rotation.Battle.Card.Primary

  var stage: BattleStage

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

// MARK: - BattleRotationStageCardSecondary

/// The secondary version of a card component that displays
/// the stage information of a battle rotation.
struct BattleRotationStageCardSecondary: View {
  typealias Scoped = Constants.Styles.Rotation.Battle.Card.Secondary

  var stage: BattleStage

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

// MARK: - BattleRotationStageCard_Previews

struct BattleRotationStageCard_Previews: PreviewProvider {
  static var previews: some View {
    BattleRotationStageCardPrimary(stage: .theReef)
      .previewLayout(.fixed(width: 320, height: 200))
    BattleRotationStageCardSecondary(stage: .humpbackPumpTrack)
      .previewLayout(.fixed(width: 300, height: 240))
  }
}
