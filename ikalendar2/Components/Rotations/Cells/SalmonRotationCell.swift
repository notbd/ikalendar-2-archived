//
//  SalmonRotationCell.swift
//  ikalendar2
//
//  Created by Tianwei Zhang on 4/4/21.
//

import SwiftUI

// MARK: - SalmonRotationCellPrimary

/// The primary version of a cell component for the salmon rotation that takes
/// all the space in the list content.
struct SalmonRotationCellPrimary: View {
  typealias Scoped = Constants.Styles.Rotation.Salmon.Cell.Primary

  @EnvironmentObject var ikaTimer: IkaTimer

  var rotation: SalmonRotation
  var width: CGFloat

  var body: some View {
    VStack(alignment: .leading, spacing: Scoped.CELL_SPACING) {
      SalmonRotationCellTimeTextSection(iconName: "salmon",
                                        rotation: rotation,
                                        width: width)

      stageAndProgressSection

      weaponsSection
        .padding(.vertical, Scoped.STAGE_PROGRESS_SECTION_PADDING)
    }
    .padding(.vertical, Scoped.CELL_PADDING)
  }

  var stageAndProgressSection: some View {
    VStack(alignment: .leading,
           spacing: Scoped.STAGE_PROGRESS_SECTION_SPACING) {
      SalmonRotationStageCard(rotation: rotation,
                              fontSize: Scoped.LABEL_FONT_SIZE,
                              swapLabels: true,
                              width: width)

      ProgressView(value: ikaTimer.currentTime - rotation.startTime,
                   total: rotation.endTime - rotation.startTime,
                   label: {
                     HStack {
                       Spacer()
                       Text(ikaTimer.currentTime.toTimeRemainingString(until: rotation.endTime))
                         .scaledLimitedLine()
                         .fontIka(.ika2, size: Scoped.PROGRESS_FONT_SIZE)
                     }
                   })
    }
  }

  var weaponsSection: some View {
    let columns: [GridItem] = [
      GridItem(.flexible()),
      GridItem(.flexible()),
      GridItem(.flexible()),
      GridItem(.flexible()),
    ]

    return
      LazyVGrid(columns: columns) {
        ForEach(Array(rotation.weapons!.enumerated()), id: \.offset) { _, weapon in
          // enumerate the array identify weapons even with same id (e.g. 4 randoms)
          SalmonRotationWeaponCardPrimary(weapon: weapon,
                                          width: width * Scoped.WEAPON_SINGLE_WIDTH_RATIO)
        }
      }
  }
}

// MARK: - SalmonRotationCellSecondary

/// The secondary version of a cell component for the salmon rotation that takes
/// all the space in the list content.
struct SalmonRotationCellSecondary: View {
  typealias Scoped = Constants.Styles.Rotation.Salmon.Cell.Secondary

  @EnvironmentObject var ikaTimer: IkaTimer

  var rotation: SalmonRotation
  var width: CGFloat

  var hasStageAndWeapon: Bool { rotation.stage != nil && rotation.weapons != nil }

  var stageHeight: CGFloat {
    width * Scoped.STAGE_HEIGHT_RATIO + Scoped.STAGE_HEIGHT_ADJUSTMENT_CONSTANT
  }

  var body: some View {
    Group {
      if !hasStageAndWeapon {
        SalmonRotationCellTertiary(rotation: rotation,
                                   width: width)
      } else {
        VStack(alignment: .leading, spacing: Scoped.CELL_SPACING) {
          SalmonRotationCellTimeTextSection(iconName: "salmon",
                                            rotation: rotation,
                                            width: width)

          stageAndWeaponSection

          if rotation.isCurrent(currentTime: ikaTimer.currentTime) {
            progressSection
          }
        }
        .padding(.vertical, Scoped.CELL_PADDING_VERTICAL)
        .padding(.bottom, Scoped.CELL_PADDING_BOTTOM)
      }
    }
  }

  var stageAndWeaponSection: some View {
    HStack {
      SalmonRotationStageCard(rotation: rotation,
                              fontSize: Scoped.LABEL_FONT_SIZE,
                              swapLabels: false,
                              width: stageHeight * (16 / 9))
        .frame(height: stageHeight)
      Spacer()
      SalmonRotationWeaponCardSecondary(weapons: rotation.weapons)
        .frame(width: stageHeight)
    }
  }

  var progressSection: some View {
    ProgressView(value: ikaTimer.currentTime - rotation.startTime,
                 total: rotation.endTime - rotation.startTime,
                 label: {
                   HStack {
                     Spacer()
                     Text(ikaTimer.currentTime.toTimeRemainingString(until: rotation.endTime))
                       .scaledLimitedLine()
                       .fontIka(.ika2, size: Scoped.PROGRESS_FONT_SIZE)
                   }
                 })
  }
}

// MARK: - SalmonRotationCellTertiary

/// The tertiary version of a cell component for the salmon rotation that takes
/// all the space in the list content.
struct SalmonRotationCellTertiary: View {
  typealias Scoped = Constants.Styles.Rotation.Salmon.Cell.Tertiary

  var rotation: SalmonRotation
  var width: CGFloat

  var body: some View {
    VStack(alignment: .leading, spacing: Scoped.CELL_SPACING) {
      SalmonRotationCellTimeTextSection(iconName: "salmon",
                                        rotation: rotation,
                                        width: width)
    }
    .padding(.vertical, Scoped.CELL_PADDING)
  }
}

// MARK: - SalmonRotationCellTimeTextSection

/// A HStack component containing the time text of a salmon rotation.
struct SalmonRotationCellTimeTextSection: View {
  typealias Scoped = Constants.Styles.Rotation.Salmon.Cell.Shared.TimeTextSection

  @EnvironmentObject var ikaTimer: IkaTimer

  var iconName: String
  var rotation: SalmonRotation
  var width: CGFloat

  var body: some View {
    HStack {
      Image(iconName)
        .resizable()
        .scaledToFit()
        .shadow(radius: Constants.Styles.Global.SHADOW_RADIUS)
        .frame(width: width * Scoped.SALMON_ICON_WIDTH_RATIO)

      Spacer()

      HStack(spacing: Scoped.TIME_TEXT_SPACING) {
        Text(rotation.startTime.toSalmonTimeString(includingDate: true,
                                                   currentTime: ikaTimer.currentTime))
          .scaledLimitedLine()
          .fontIka(.ika2, size: Scoped.TIME_TEXT_FONT_SIZE)
          .padding(.horizontal, Scoped.TIME_TEXT_SINGLE_PADDING_HORIZONTAL)
          .silhouetteFrame(cornerRadius: Scoped.TIME_TEXT_SILHOUETTE_CORNER_RADIUS)
        Text("-")
          .scaledLimitedLine()
          .fontIka(.ika2, size: Scoped.TIME_TEXT_FONT_SIZE)

        Text(rotation.endTime.toSalmonTimeString(includingDate: true,
                                                 currentTime: ikaTimer.currentTime))
          .scaledLimitedLine()
          .fontIka(.ika2, size: Scoped.TIME_TEXT_FONT_SIZE)
          .padding(.horizontal, Scoped.TIME_TEXT_SINGLE_PADDING_HORIZONTAL)
          .silhouetteFrame(cornerRadius: Scoped.TIME_TEXT_SILHOUETTE_CORNER_RADIUS)
      }
    }
    .padding(.vertical, Scoped.TIME_TEXT_SECTION_PADDING)
  }
}

// struct SalmonRotationCell_Previews: PreviewProvider {
//    static var previews: some View {
//        SalmonRotationCell()
//    }
// }
