//
//  SidebarView.swift
//  ikalendar2
//
//  Created by Tianwei Zhang on 4/11/21.
//

import SwiftUI

// MARK: - SidebarView

/// The sidebar in the iPad layout.
struct SidebarView: View {
  @EnvironmentObject var ikaStatus: IkaStatus

  var body: some View {
    ScrollView {
      ForEach(FlatMode.allCases) { flatMode in
        HStack {
          Button {
            ikaStatus.flatModeSelection = flatMode
          } label: {
            SidebarLabel(currFlatMode: flatMode,
                         selection: ikaStatus.flatModeSelection)
          }
          .animation(.spring())
        }
      }
    }
    .fixFlickering { scrollView in
      scrollView
        .padding(.top, 20)
        .padding(.horizontal, 10)
    }
    .navigationTitle("Mode")
  }
}

// MARK: - SidebarLabel

struct SidebarLabel: View {
  var currFlatMode: FlatMode
  var selection: FlatMode

  var body: some View {
    HStack(spacing: 16) {
      Image(currFlatMode.imgFiln)
        .renderingMode(.original)
        .resizable()
        .scaledToFit()
        .shadow(radius: 5)
        .frame(width: 24)

      Text(currFlatMode.name)
        .font(.system(size: 24, weight: .semibold, design: .rounded))
        .fontWeight(.semibold)
      Spacer()
    }
    .padding()
    .offset(x: -10)
    .foregroundColor(.primary)
    .background(selection == currFlatMode ?
      Color(UIColor.systemGray4) : .clear)
    .cornerRadius(10)
  }
}

// MARK: - SidebarView_Previews

struct SidebarView_Previews: PreviewProvider {
  static var previews: some View {
    SidebarView()
  }
}
