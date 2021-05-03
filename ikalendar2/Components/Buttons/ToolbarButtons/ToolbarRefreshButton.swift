//
//  ToolbarRefreshButton.swift
//  ikalendar2
//
//  Created by Tianwei Zhang on 3/27/21.
//

import SwiftUI

// MARK: - ToolbarRefreshButton

/// A refresh button in the toolbar.
struct ToolbarRefreshButton: View {
  let alignment: ToolbarButtonAlignment
  let isDisabled: Bool
  let action: () -> Void

  var body: some View {
    HStack {
      if alignment == .trailing || alignment == .centered {
        Spacer()
      }

      Button(action: action) {
        ToolbarRefreshButtonLabel(alignment: alignment)
      }
      .disabled(isDisabled)

      if alignment == .leading || alignment == .centered {
        Spacer()
      }
    }
  }
}

// MARK: - ToolbarRefreshButtonLabel

/// The label of ToolbarRefreshButton.
struct ToolbarRefreshButtonLabel: View {
  typealias Scoped = Constants.Styles.ToolbarButton

  let alignment: ToolbarButtonAlignment

  var body: some View {
    HStack {
      if alignment == .trailing || alignment == .centered {
        Spacer()
      }

      Image(systemName: "arrow.triangle.2.circlepath")
        .foregroundColor(.primary)
        .font(Scoped.SFSYMBOL_FONT)
        .shadow(radius: Constants.Styles.Global.SHADOW_RADIUS)
        .frame(width: Scoped.SILHOUETTE_SIDE, height: Scoped.SILHOUETTE_SIDE)
        .silhouetteFrame(cornerRadius: Scoped.SILHOUETTE_CORNER_RADIUS)

      if alignment == .leading || alignment == .centered {
        Spacer()
      }
    }
    .tappableAreaFrame()
  }
}

// MARK: - ToolbarRefreshButton_Previews

struct ToolbarRefreshButton_Previews: PreviewProvider {
  static var previews: some View {
    ToolbarRefreshButton(alignment: .centered,
                         isDisabled: false,
                         action: { print("preview") })
  }
}
