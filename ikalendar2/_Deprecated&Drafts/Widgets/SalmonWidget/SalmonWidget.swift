//
//  SalmonWidget.swift
//  IkaWidgetExtension
//
//  Created by Tianwei Zhang on 4/24/21.
//

import Intents
import SwiftUI
import WidgetKit

// MARK: - SalmonProvider

/// Provider for Salmon Widget.
struct SalmonProvider: IntentTimelineProvider {
  func placeholder(in _: Context) -> SalmonEntry {
    SalmonEntry(rotation: MockData.getSalmonRotation())
  }

  func getSnapshot(
    for _: SalmonWidgetConfigurationIntent,
    in _: Context,
    completion: @escaping (SalmonEntry) -> Void)
  {
    let entry = SalmonEntry(rotation: MockData.getSalmonRotation())
    completion(entry)
  }

  func getTimeline(
    for configuration: SalmonWidgetConfigurationIntent,
    in _: Context,
    completion: @escaping (Timeline<Entry>) -> Void)
  {
    var entries: [SalmonEntry] = []

    var indexSelection: Int
    switch configuration.viewType {
    case .current:
      indexSelection = 0
    case .next:
      indexSelection = 1
    case .unknown:
      indexSelection = 0
    }
    NetworkManager.shared.asyncGetSalmonRotationArray { result in
      switch result {
      case let .success(rotations):
        let entry = SalmonEntry(rotation: rotations[indexSelection])
        entries.append(entry)
      case .failure:
        let entry = SalmonEntry(rotation: MockData.getSalmonRotation())
        entries.append(entry)
      }
      let timeline = Timeline(entries: entries, policy: .never)
      completion(timeline)
    }
  }
}

// MARK: - SalmonEntry

/// Entry struct for Salmon Widget.
struct SalmonEntry: TimelineEntry {
  let rotation: SalmonRotation
  var date: Date { rotation.startTime }
}

// MARK: - SalmonWidget

/// Widget struct for Salmon Widget.
struct SalmonWidget: Widget {
  let kind: String = "Salmon"

  var body: some WidgetConfiguration {
    IntentConfiguration(kind: kind,
                        intent: SalmonWidgetConfigurationIntent.self,
                        provider: SalmonProvider()) { entry in
        SalmonWidgetEntryView(entry: entry)
    }
    .configurationDisplayName("Salmon Rotations")
    .description("View the upcoming salmon rotations.")
    .supportedFamilies([.systemMedium])
  }
}

// MARK: - SalmonWidget_Previews

struct SalmonWidget_Previews: PreviewProvider {
  static var previews: some View {
    SalmonWidgetEntryView(entry: SalmonEntry(rotation: MockData.getSalmonRotation()))
      .previewContext(WidgetPreviewContext(family: .systemMedium))
  }
}

// MARK: - SalmonWidgetEntryView

/// View for Salmon Widget.
struct SalmonWidgetEntryView: View {
  var entry: SalmonProvider.Entry

  var rotation: SalmonRotation { entry.rotation }

  var body: some View {
    GeometryReader { geo in
      VStack {
        HStack(spacing: 6) {
          titleSection
          timeTextSection
        }

        HStack(spacing: 6) {
          salmonStageCard
            .frame(width: geo.size.width * 0.4)
          salmonWeaponCardGroup
            .frame(width: geo.size.width * 0.5)
        }
      }
    }
    .padding()
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
      .frame(maxWidth: .infinity)
      .cornerRadius(8)
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
