//
//  MatchRotationCell.swift
//  ikalendar2
//
//  Created by Tianwei Zhang on 3/28/21.
//

import SwiftUI

// MARK: - MatchRotationCellPrimary

/// The primary version of a cell component for the match rotation that takes
/// all the space in the list content.
struct MatchRotationCellPrimary: View {
  typealias Scoped = Constants.Styles.Rotation.Match.Cell.Primary

  @Environment(\.horizontalSizeClass) private var horizontalSizeClass
  var isHorizontalCompact: Bool { horizontalSizeClass == .compact }

  @EnvironmentObject var ikaTimer: IkaTimer
  @EnvironmentObject var ikaPreference: IkaPreference

  var rotation: MatchRotation
  var width: CGFloat

  var body: some View {
    VStack {
      HStack(alignment: .center) {
        ruleSection
        Spacer()
        remainingTimeSection
      }

      // If no spacer here layout will break??? Can't find the bug here
      Spacer()

      ProgressView(value: ikaTimer.currentTime - rotation.startTime,
                   total: rotation.endTime - rotation.startTime)
        .padding(.bottom, 4)

      HStack(alignment: .center,
             spacing: width * Scoped.STAGE_SECTION_SPACING_RATIO) {
          MatchRotationStageCardPrimary(stage: rotation.stageA)
          MatchRotationStageCardPrimary(stage: rotation.stageB)
      }
    }
    .padding(.top, Scoped.CELL_PADDING_TOP)
    .padding(.bottom, Scoped.CELL_PADDING_BOTTOM)
  }

  // MARK: Rule Section

  var ruleSection: some View {
    HStack(alignment: .center,
           spacing: Scoped.RULE_SECTION_SPACING) {
        // Rule icon
        Image(rotation.rule.imgFilnMid)
          .resizable()
          .antialiased(true)
          .scaledToFit()
          .shadow(radius: Constants.Styles.Global.SHADOW_RADIUS)
          .frame(maxWidth: width * Scoped.RULE_IMG_MAX_WIDTH_RATIO)

        // Rule title
        Text(rotation.rule.name.localizedStringKey())
          .scaledLimitedLine()
          .fontIka(.ika2,
                   size: isHorizontalCompact ?
                     Scoped.RULE_FONT_SIZE_COMPACT :
                     Scoped.RULE_FONT_SIZE_REGULAR)
    }
    .frame(height: width * Scoped.RULE_SECTION_HEIGHT_RATIO)
  }

  // MARK: Remaining Time Section

  var remainingTimeSection: some View {
    HStack {
      Spacer()
      HStack {
        Spacer()
        Text(ikaTimer.currentTime.toTimeRemainingString(until: rotation.endTime))
          .scaledLimitedLine()
          .foregroundColor(.secondary)
          .fontIka(.ika2,
                   size: width * Scoped.REMAINING_TIME_FONT_RATIO)
      }
      .frame(maxWidth: width * Scoped.REMAINING_TIME_TEXT_MAX_WIDTH_RATIO)
    }
    .frame(width: width * Scoped.REMAINING_TIME_SECTION_WIDTH_RATIO)
  }
}

// MARK: - MatchRotationCellSecondary

/// The secondary version of a cell component for the match rotation
/// that takes all the space in a list unit.
struct MatchRotationCellSecondary: View {
  typealias Scoped = Constants.Styles.Rotation.Match.Cell.Secondary

  @EnvironmentObject var ikaPreference: IkaPreference

  var rotation: MatchRotation
  var width: CGFloat

  var body: some View {
    HStack {
      // MARK: Rule section

      VStack(spacing: Scoped.RULE_SECTION_SPACING) {
        // Rule img
        Image(rotation.rule.imgFilnMid)
          .resizable()
          .antialiased(true)
          .scaledToFit()
          .shadow(radius: Constants.Styles.Global.SHADOW_RADIUS)
          .frame(maxWidth: width * Scoped.RULE_IMG_MAX_WIDTH)
          .padding(Scoped.RULE_IMG_PADDING)
          .silhouetteFrame(cornerRadius: Scoped.RULE_IMG_SILHOUETTE_CORNER_RADIUS)

        // Rule title
        Text(rotation.rule.name.localizedStringKey())
          .scaledLimitedLine()
          .fontIka(.ika2, size: Scoped.RULE_FONT_SIZE)
          .frame(height: Scoped.RULE_TITLE_HEIGHT)
      }
      .frame(maxWidth: width * Scoped.RULE_SECTION_WIDTH_RATIO)
      .padding(.trailing, Scoped.RULE_SECTION_PADDING_TRAILING)

      // MARK: Stage Section

      HStack(alignment: .center,
             spacing: width * Scoped.STAGE_SECTION_SPACING_RATIO +
               Scoped.STAGE_SECTION_SPACING_ADJUSTMENT_CONSTANT) {
          MatchRotationStageCardSecondary(stage: rotation.stageA)
          MatchRotationStageCardSecondary(stage: rotation.stageB)
      }
    }
  }
}

// MARK: - MatchRotationCell_Previews

struct MatchRotationCell_Previews: PreviewProvider {
  static var previews: some View {
    GeometryReader { geometry in
      List {
        Section {
          MatchRotationCellPrimary(rotation: MockData.getMatchRotation(rule: .towerControl,
                                                                       rawStartTime: Date()),
                                   width: geometry.size.width)
        }
        Section {
          MatchRotationCellSecondary(rotation: MockData.getMatchRotation(rule: .clamBlitz,
                                                                         rawStartTime: Date()),
                                     width: geometry.size.width)
        }
      }
      .listStyle(InsetGroupedListStyle())
    }
  }
}
