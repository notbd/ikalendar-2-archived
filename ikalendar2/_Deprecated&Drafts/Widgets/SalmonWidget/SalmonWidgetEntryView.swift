//
//  SalmonWidgetEntryView.swift
//  IkaWidgetExtension
//
//  Created by Tianwei Zhang on 4/25/21.
//

import SwiftUI
import WidgetKit

// MARK: - SalmonWidgetEntryView

/// View for Salmon Widget.
struct SalmonWidgetEntryView: View {
  var entry: SalmonProvider.Entry

  var rotation: SalmonRotation { entry.rotation }

  var body: some View {
    VStack {
      HStack(spacing: 6) {
        titleSection
        timeTextSection
      }
      HStack(spacing: 6) {
        salmonStageCard
        salmonWeaponCardGroup
      }
    }
    .padding(5)
  }

  var titleSection: some View {
    HStack(spacing: 6) {
      Image("salmon")
        .resizable()
        .scaledToFit()
        .frame(width: 20)
      Text(GameMode.salmon.name.localizedStringKey())
        .scaledLimitedLine()
        .fontIka(.ika1, size: 14)
        .foregroundColor(Color.primary)
    }
  }

  var timeTextSection: some View {
    HStack(spacing: 6) {
      Text(rotation.startTime.toSalmonTimeString(includingDate: true))
        .scaledLimitedLine()
        .fontIka(.ika2, size: 14)
        .padding(.horizontal, 2)
      Text("-")
        .scaledLimitedLine()
        .fontIka(.ika2, size: 14)

      Text(rotation.endTime.toSalmonTimeString(includingDate: true))
        .scaledLimitedLine()
        .fontIka(.ika2, size: 14)
        .padding(.horizontal, 2)
    }
  }

  var salmonStageCard: some View {
    Image(rotation.stage!.imgFiln)
      .resizable()
      .scaledToFit()
      .frame(width: 20)
  }

  var salmonWeaponCardGroup: some View {
    HStack {
      ForEach(Array(rotation.weapons!.enumerated()), id: \.offset) { _, weapon in
        // enumerate the array identify weapons even with same id (e.g. 4 randoms)
        Image(weapon.imgFiln)
          .resizable()
          .scaledToFit()
          .shadow(radius: Constants.Styles.Global.SHADOW_RADIUS)
      }
    }
  }
}
