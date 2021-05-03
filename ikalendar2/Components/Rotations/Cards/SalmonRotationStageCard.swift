//
//  SalmonRotationStageCard.swift
//  ikalendar2
//
//  Created by Tianwei Zhang on 4/4/21.
//

import SwiftUI

// MARK: - SalmonRotationStageCardPrimary

/// A card component that displays the stage information of a salmon rotation.
struct SalmonRotationStageCard: View {
  typealias Scoped = Constants.Styles.Rotation.Salmon.Card.Stage

  @EnvironmentObject var ikaTimer: IkaTimer

  var rotation: SalmonRotation
  let fontSize: CGFloat
  let swapLabels: Bool
  var width: CGFloat

  var body: some View {
    Image(rotation.stage!.imgFiln)
      .antialiased(true)
      .resizable()
      .scaledToFit()
      .cornerRadius(Scoped.STAGE_IMG_CORNER_RADIUS)
      .shadow(radius: Constants.Styles.Global.SHADOW_RADIUS)
      .overlay(overlay,
               alignment: .bottom)
  }

  var overlay: some View {
    HStack(alignment: .bottom) {
      if swapLabels {
        stageTitleLabel
        Spacer()
      }
      HStack(alignment: .bottom) {
        if swapLabels {
          Spacer()
        }
        rewardGearImg
        if !swapLabels {
          Spacer()
        }
      }
      .frame(width: width * Scoped.GEAR_SECTION_WIDTH_RATIO)
      if !swapLabels {
        Spacer()
        stageTitleLabel
      }
    }
    .padding(.bottom, Scoped.OVERLAY_PADDING)
    .padding(.horizontal, Scoped.OVERLAY_PADDING)
  }

  var stageTitleLabel: some View {
    StageTitleLabel(title: rotation.stage!.name,
                    fontSize: fontSize)
  }

  var rewardGearImg: some View {
    var isShown: Bool {
      rotation.isCurrent(currentTime: ikaTimer.currentTime) && rotation.rewardGear != nil
    }
    var content: some View {
      Image(rotation.rewardGear?.imgFiln ?? "salmon")
        .resizable()
        .scaledToFit()
        .padding(Scoped.GEAR_IMG_PADDING)
        .frame(width: width * Scoped.GEAR_IMG_WIDTH_RATIO)
        .silhouetteFrame(cornerRadius: Scoped.GEAR_SILHOUETTE_CORNER_RADIUS,
                         colorScheme: .light)
    }
    return content
      .opacity(isShown ? 1 : 0)
  }
}

// struct SalmonRotationStageCard_Previews: PreviewProvider {
//    static var previews: some View {
//        SalmonRotationStageCard()
//    }
// }
