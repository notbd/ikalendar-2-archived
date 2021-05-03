//
//  ToolbarSFButton.swift
//  ikalendar2
//
//  Created by Tianwei Zhang on 4/15/21.
//

import SwiftUI

// MARK: - ToolbarSFButton

struct ToolbarSFButton: View {
  let name: String
  let alignment: ToolbarButtonAlignment
  let action: () -> Void

  var body: some View {
    HStack {
      if alignment == .trailing || alignment == .centered {
        Spacer()
      }

      Button(action: action) {
        ToolbarSFButtonLabel(name: name,
                             alignment: alignment)
      }

      if alignment == .leading || alignment == .centered {
        Spacer()
      }
    }
  }
}

// MARK: - ToolbarSFButtonLabel

struct ToolbarSFButtonLabel: View {
  typealias Scoped = Constants.Styles.ToolbarButton

  let name: String
  let alignment: ToolbarButtonAlignment

  var body: some View {
    HStack {
      if alignment == .trailing || alignment == .centered {
        Spacer()
      }

      Image(systemName: name)
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

// MARK: - ToolbarSFButton_Previews

struct ToolbarSFButton_Previews: PreviewProvider {
  static var previews: some View {
    ToolbarSFButton(name: "gear",
                    alignment: .leading,
                    action: { print("preview") })
  }
}
