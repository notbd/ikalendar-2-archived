//
//  MatchWidgetEntryView.swift
//  IkaWidgetExtension
//
//  Created by Tianwei Zhang on 4/25/21.
//

import SwiftUI
import WidgetKit

// MARK: - MatchWidgetEntryView

/// View for Match Widget.
struct MatchWidgetEntryView: View {
  var entry: MatchProvider.Entry

  var rotation: MatchRotation { entry.rotation }
  var startTimeString: String {
    rotation.startTime.toMatchTimeString()
  }

  var endTimeString: String {
    rotation.endTime.toMatchTimeString()
  }

  var body: some View {
    HStack {
      VStack(alignment: .leading) {
        matchModeSection

        timeTextSection

        matchRuleSection
      }
      .padding()
      .layoutPriority(1)
      stageSection
        .shadow(radius: 4)
        .layoutPriority(1)
    }
  }

  var matchModeSection: some View {
    HStack(spacing: 6) {
      Image(entry.matchMode.imgFilnSmall)
        .resizable()
        .scaledToFit()
        .frame(width: 20)
      Text(entry.matchMode.name.localizedStringKey())
        .scaledLimitedLine()
        .fontIka(.ika1, size: 14)
        .foregroundColor(Color.primary)
    }
  }

  var timeTextSection: some View {
    HStack(spacing: 6) {
      // Prefix
      ZStack {
        Rectangle()
          .foregroundColor(Color.primary)
          .cornerRadius(5)

        Text("Now:".localizedStringKey())
          .fontIka(.ika1, size: 8)
          .foregroundColor(Color.systemBackground)
          .padding(.horizontal, 3)
      }
      .fixedSize()

      // Content
      Text("\(startTimeString) - \(endTimeString)")
        .scaledLimitedLine()
        .fontIka(.ika1, size: 14)
        .foregroundColor(.secondary)
    }
  }

  var matchRuleSection: some View {
    VStack {
      Spacer()
      HStack(alignment: .center,
             spacing: 6) {
          // Rule icon
          Image(rotation.rule.imgFilnMid)
            .resizable()
            .antialiased(true)
            .scaledToFit()
            .shadow(radius: Constants.Styles.Global.SHADOW_RADIUS)
            .frame(width: 28)

          // Rule title
          Text(rotation.rule.name.localizedStringKey())
            .scaledLimitedLine()
            .fontIka(.ika2,
                     size: 20)
      }
      Spacer()
    }
  }

  var stageSection: some View {
    GeometryReader { geo in
      VStack(spacing: 0) {
        MatchWidgetStageCard(stage: rotation.stageA,
                             height: geo.size.height / 2)
          .layoutPriority(1)
        MatchWidgetStageCard(stage: rotation.stageB,
                             height: geo.size.height / 2)
          .layoutPriority(1)
      }
    }
  }
}

// MARK: - MatchWidgetStageCard

/// StageCard subView for Match Widget.
struct MatchWidgetStageCard: View {
  var stage: MatchStage
  var height: CGFloat
  var body: some View {
    Image(stage.imgFiln)
      .resizable()
      .scaledToFill()
      .frame(height: height)
      .overlay(StageTitleLabel(title: stage.name.localizedCapitalized,
                               fontSize: 12,
                               avoidBlur: true),
               alignment: .center)
  }
}
