//
//  SalmonRotationRow.swift
//  ikalendar2
//
//  Created by Tianwei Zhang on 4/4/21.
//

import SwiftUI

// MARK: - SalmonRotationRow

/// A row containing all the information of a salmon rotation.
struct SalmonRotationRow: View {
  @Environment(\.horizontalSizeClass) private var horizontalSizeClass

  @EnvironmentObject var ikaTimer: IkaTimer

  var rotation: SalmonRotation
  var index: Int
  var width: CGFloat

  var rowType: RowType {
    typealias Scoped = Constants.Styles.Rotation.Salmon.Header

    if index == 0 {
      if rotation.isCurrent(currentTime: ikaTimer.currentTime) {
        return .first(.busy)
      } else {
        return .first(.idle)
      }
    } else if index == 1 {
      return .second
    } else {
      return .other
    }
  }

  var body: some View {
    Group {
      switch rowType {
      case .other:
        Section {
          SalmonRotationCellSecondary(rotation: rotation, width: width)
        }

      default:
        Section(header: SalmonRotationHeader(prefixString: rowType.prefixString)) {
          switch rowType {
          case .first(.busy):
            switch horizontalSizeClass {
            case .regular:
              SalmonRotationCellPrimary(rotation: rotation, width: width)
            default:
              SalmonRotationCellSecondary(rotation: rotation, width: width)
            }
          default:
            SalmonRotationCellSecondary(rotation: rotation, width: width)
          }
        }
      }
    }
  }
}

extension SalmonRotationRow {
  enum RowType {
    typealias Scoped = Constants.Styles.Rotation.Salmon.Header

    case first(SalmonCurrentStatus)
    case second
    case other

    enum SalmonCurrentStatus {
      case busy
      case idle
    }

    var prefixString: String {
      switch self {
      case let .first(currentStatus):
        switch currentStatus {
        case .busy:
          return Scoped.FIRST_PREFIX_STRINGS.busy
        case .idle:
          return Scoped.FIRST_PREFIX_STRINGS.idle
        }

      case .second:
        return Scoped.SECOND_PREFIX_STRING
      case .other:
        return ""
      }
    }
  }
}

// MARK: - SalmonRotationHeader

/// The header of the salmon rotation row.
struct SalmonRotationHeader: View {
  typealias Scoped = Constants.Styles.Rotation.Salmon.Header

  var prefixString: String

  var body: some View {
    HStack(spacing: Scoped.SPACING) {
      Text(prefixString.localizedStringKey())
        .fontIka(.ika1, size: Scoped.FONT_SIZE)
        .foregroundColor(Color.systemBackground)
        .padding(.horizontal, Scoped.PREFIX_PADDING)
        .silhouetteFrame(cornerRadius: Scoped.PREFIX_SILHOUETTE_CORNER_RADIUS,
                         colorScheme: .inverted)
    }
  }
}

// struct SalmonRotationRow_Previews: PreviewProvider {
//  static var previews: some View {
//    SalmonRotationRow()
//  }
// }
