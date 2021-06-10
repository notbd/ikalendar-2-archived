//
//  BattleRotationRow.swift
//  ikalendar2
//
//  Created by Tianwei Zhang on 3/28/21.
//

import SwiftUI

// MARK: - BattleRotationRow

/// A row containing all the information of a battle rotation.
struct BattleRotationRow: View {
  @EnvironmentObject var ikaTimer: IkaTimer

  var rotation: BattleRotation
  var index: Int
  var width: CGFloat

  var rowType: RowType {
    typealias Scoped = Constants.Styles.Rotation.Battle.Header

    if rotation.isCurrent(currentTime: ikaTimer.currentTime) {
      return .now
    } else if rotation.isNext(currentTime: ikaTimer.currentTime) {
      return .next
    } else {
      return .other
    }
  }

  var body: some View {
    Section(header: BattleRotationHeader(rotation: rotation,
                                         rowType: rowType)) {
      switch rowType {
      case .now:
        BattleRotationCellPrimary(rotation: rotation,
                                  width: width)
      default:
        BattleRotationCellSecondary(rotation: rotation,
                                    width: width)
      }
    }
  }
}

extension BattleRotationRow {
  enum RowType {
    typealias Scoped = Constants.Styles.Rotation.Battle.Header

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

// MARK: - BattleRotationHeader

/// The header of the battle rotation row.
struct BattleRotationHeader: View {
  typealias Scoped = Constants.Styles.Rotation.Battle.Header

  @EnvironmentObject var ikaTimer: IkaTimer

  var rotation: BattleRotation
  var rowType: BattleRotationRow.RowType

  var startTimeString: String {
    if
      Calendar.current.isDateInYesterday(rotation.startTime) ||
      Calendar.current.isDateInTomorrow(rotation.startTime)
    {
      return rotation.startTime.toBattleTimeString(includingDate: true,
                                                   currentTime: ikaTimer.currentTime)
    } else {
      return rotation.startTime.toBattleTimeString()
    }
  }

  var endTimeString: String {
    if
      (Calendar.current.isDateInYesterday(rotation.startTime) &&
        Calendar.current.isDateInToday(rotation.endTime)) ||
      (Calendar.current.isDateInToday(rotation.startTime) &&
        Calendar.current.isDateInTomorrow(rotation.endTime))
    {
      return rotation.endTime.toBattleTimeString(includingDate: true,
                                                 currentTime: ikaTimer.currentTime)
    } else {
      return rotation.endTime.toBattleTimeString()
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

// MARK: - BattleRotationRow_Previews

struct BattleRotationRow_Previews: PreviewProvider {
  @State static var modeSelection = BattleMode.gachi

  static var previews: some View {
    NavigationView {
      GeometryReader { geometry in
        List {
          Section {
            Picker("Mode", selection: $modeSelection) {
              ForEach(BattleMode.allCases) { battleMode in
                Text(battleMode.shortName)
                  .tag(battleMode)
              }
            }
            .pickerStyle(SegmentedPickerStyle())
          }

          ForEach(0 ..< MockData.getBattleRotations()[modeSelection]!.count) { index in
            BattleRotationRow(rotation: MockData.getBattleRotations()[modeSelection]![index],
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
