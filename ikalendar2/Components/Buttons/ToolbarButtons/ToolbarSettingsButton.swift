//
//  ToolbarSettingsButton.swift
//  ikalendar2
//
//  Created by Tianwei Zhang on 3/27/21.
//

import SwiftUI

// MARK: - ToolbarSettingsButton

// A settings button in the toolbar.
struct ToolbarSettingsButton: View {
  let alignment: ToolbarButtonAlignment
  let action: () -> Void

  var body: some View {
    HStack {
      if alignment == .trailing || alignment == .centered {
        Spacer()
      }

      Button(action: action) {
        ToolbarSettingsButtonLabel(alignment: alignment)
      }

      if alignment == .leading || alignment == .centered {
        Spacer()
      }
    }
  }
}

// MARK: - ToolbarSettingsButtonLabel

// The label of ToolbarSettingsButton.
struct ToolbarSettingsButtonLabel: View {
  typealias Scoped = Constants.Styles.ToolbarButton

  let alignment: ToolbarButtonAlignment

  var body: some View {
    HStack {
      if alignment == .trailing || alignment == .centered {
        Spacer()
      }

      Image(systemName: "gear")
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

// MARK: - ToolbarSettingsButton_Previews

struct ToolbarSettingsButton_Previews: PreviewProvider {
  static var previews: some View {
    ToolbarSettingsButton(alignment: .leading,
                          action: { print("preview") })
  }
}
