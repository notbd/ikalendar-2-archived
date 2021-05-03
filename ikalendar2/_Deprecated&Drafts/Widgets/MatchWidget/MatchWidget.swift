//
//  MatchWidget.swift
//  IkaWidgetExtension
//
//  Created by Tianwei Zhang on 4/24/21.
//

import Intents
import SwiftUI
import WidgetKit

// MARK: - MatchProvider

/// Provider for Match Widget.
struct MatchProvider: IntentTimelineProvider {
  func placeholder(in _: Context) -> MatchEntry {
    MatchEntry(rotation: MockData.getMatchRotation(rule: .towerControl),
               matchMode: .gachi)
  }

  func getSnapshot(
    for configuration: MatchWidgetConfigurationIntent,
    in _: Context,
    completion: @escaping (MatchEntry) -> Void)
  {
    var entry: MatchEntry
    switch configuration.matchModeSelection {
    case .regular:
      entry = MatchEntry(rotation: MockData.getMatchRotation(rule: .turfWar),
                         matchMode: .regular)
    case .ranked:
      entry = MatchEntry(rotation: MockData.getMatchRotation(rule: .towerControl),
                         matchMode: .gachi)
    case .league:
      entry = MatchEntry(rotation: MockData.getMatchRotation(rule: .rainmaker),
                         matchMode: .league)
    case .unknown:
      entry = MatchEntry(rotation: MockData.getMatchRotation(rule: .towerControl),
                         matchMode: .gachi)
    }
    completion(entry)
  }

  func getTimeline(
    for configuration: MatchWidgetConfigurationIntent,
    in _: Context,
    completion: @escaping (Timeline<Entry>) -> Void)
  {
    var entries: [MatchEntry] = []

    var matchModeSelection: MatchMode
    switch configuration.matchModeSelection {
    case .regular:
      matchModeSelection = .regular
    case .ranked:
      matchModeSelection = .gachi
    case .league:
      matchModeSelection = .league
    case .unknown:
      matchModeSelection = .gachi
    }

    NetworkManager.shared.asyncGetMatchRotationDict { result in
      switch result {
      case let .success(dict):
        for index in 0 ..< dict.numOfRounds {
          let entry = MatchEntry(rotation: dict[matchModeSelection]![index],
                                 matchMode: matchModeSelection)
          entries.append(entry)
        }

      case .failure:
        let matchRotationDict = MockData.getMatchRotations()
        for index in 0 ..< matchRotationDict.numOfRounds {
          let entry = MatchEntry(rotation: matchRotationDict[matchModeSelection]![index],
                                 matchMode: matchModeSelection)
          entries.append(entry)
        }
      }

      let timeline = Timeline(entries: entries, policy: .atEnd)
      completion(timeline)
    }
  }
}

// MARK: - MatchEntry

/// Entry struct for Match Widget.
struct MatchEntry: TimelineEntry {
  let rotation: MatchRotation
  let matchMode: MatchMode
  var date: Date { rotation.startTime }
}

// MARK: - MatchWidget

/// Widget struct for Match Widget.
struct MatchWidget: Widget {
  let kind: String = "Match"

  var body: some WidgetConfiguration {
    IntentConfiguration(kind: kind,
                        intent: MatchWidgetConfigurationIntent.self,
                        provider: MatchProvider()) { entry in
        MatchWidgetEntryView(entry: entry)
    }
    .configurationDisplayName("Battle Rotations")
    .description("View the upcoming battle rotations.")
    .supportedFamilies([.systemMedium])
  }
}

// MARK: - MatchWidget_Previews

struct MatchWidget_Previews: PreviewProvider {
  static var previews: some View {
    MatchWidgetEntryView(entry:
      MatchEntry(rotation: MockData.getMatchRotation(rule: .towerControl),
                 matchMode: .gachi))
      .previewContext(WidgetPreviewContext(family: .systemMedium))
  }
}

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
