//
//  MatchRotationRow.swift
//  ikalendar2
//
//  Created by Tianwei Zhang on 3/28/21.
//

import SwiftUI

// MARK: - MatchRotationRow

/// A row containing all the information of a match rotation.
struct MatchRotationRow: View {
  @EnvironmentObject var ikaTimer: IkaTimer

  var rotation: MatchRotation
  var index: Int
  var width: CGFloat

  var rowType: RowType {
    typealias Scoped = Constants.Styles.Rotation.Match.Header

    if rotation.isCurrent(currentTime: ikaTimer.currentTime) {
      return .now
    } else if rotation.isNext(currentTime: ikaTimer.currentTime) {
      return .next
    } else {
      return .other
    }
  }

  var body: some View {
    Section(header: MatchRotationHeader(rotation: rotation,
                                        rowType: rowType)) {
        switch rowType {
        case .now:
          MatchRotationCellPrimary(rotation: rotation,
                                   width: width)
        default:
          MatchRotationCellSecondary(rotation: rotation,
                                     width: width)
        }
    }
  }
}

extension MatchRotationRow {
  enum RowType {
    typealias Scoped = Constants.Styles.Rotation.Match.Header

    case now
    case next
    case other

    var prefixString: String {
      switch self {
      case .now:
        return Scoped.CURRENT_PREFIX_STRING
      case .next:
        return Scoped.NEXT_PREFIX_STRING
      case .other:
        return ""
      }
    }
  }
}

// MARK: - MatchRotationHeader

/// The header of the match rotation row.
struct MatchRotationHeader: View {
  typealias Scoped = Constants.Styles.Rotation.Match.Header

  @EnvironmentObject var ikaTimer: IkaTimer

  var rotation: MatchRotation
  var rowType: MatchRotationRow.RowType

  var startTimeString: String {
    if
      Calendar.current.isDateInYesterday(rotation.startTime) ||
      Calendar.current.isDateInTomorrow(rotation.startTime)
    {
      return rotation.startTime.toMatchTimeString(includingDate: true,
                                                  currentTime: ikaTimer.currentTime)
    } else {
      return rotation.startTime.toMatchTimeString()
    }
  }

  var endTimeString: String {
    if
      (Calendar.current.isDateInYesterday(rotation.startTime) &&
        Calendar.current.isDateInToday(rotation.endTime)) ||
      (Calendar.current.isDateInToday(rotation.startTime) &&
        Calendar.current.isDateInTomorrow(rotation.endTime))
    {
      return rotation.endTime.toMatchTimeString(includingDate: true,
                                                currentTime: ikaTimer.currentTime)
    } else {
      return rotation.endTime.toMatchTimeString()
    }
  }

  var body: some View {
    HStack(spacing: Scoped.SPACING) {
      // Prefix
      if !rowType.prefixString.isEmpty {
        Text(rowType.prefixString.localizedStringKey())
          .fontIka(.ika1, size: Scoped.PREFIX_FONT_SIZE)
          .foregroundColor(Color.systemBackground)
          .padding(.horizontal, Scoped.PREFIX_PADDING)
          .silhouetteFrame(cornerRadius: Scoped.PREFIX_SILHOUETTE_CORNER_RADIUS,
                           colorScheme: .inverted)
      }

      // Content
      Text("\(startTimeString) - \(endTimeString)")
        .scaledLimitedLine()
        .fontIka(.ika1, size: Scoped.CONTENT_FONT_SIZE)
        .foregroundColor(.secondary)
    }
  }
}

// MARK: - MatchRotationRow_Previews

struct MatchRotationRow_Previews: PreviewProvider {
  @State static var modeSelection = MatchMode.gachi

  static var previews: some View {
    NavigationView {
      GeometryReader { geometry in
        List {
          Section {
            Picker("Mode", selection: $modeSelection) {
              ForEach(MatchMode.allCases) { matchMode in
                Text(matchMode.shortName)
                  .tag(matchMode)
              }
            }
            .pickerStyle(SegmentedPickerStyle())
          }

          ForEach(0 ..< MockData.getMatchRotations()[modeSelection]!.count) { index in
            MatchRotationRow(rotation: MockData.getMatchRotations()[modeSelection]![index],
                             index: index,
                             width: geometry.size.width)
          }
        }
        .listStyle(InsetGroupedListStyle())
        .navigationTitle(modeSelection.name)
      }
    }
  }
}
