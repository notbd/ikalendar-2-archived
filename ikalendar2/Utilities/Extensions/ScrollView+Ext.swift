//
//  ScrollView+Ext.swift
//  ikalendar2
//
//  Created by Tianwei Zhang on 4/12/21.
//

import SwiftUI

extension ScrollView {
  /// Fix the flickering of a ScrollView inside a NavigationView.
  /// - Returns: The fixed ScrollView.
  func fixFlickering() -> some View {
    fixFlickering { scrollView in
      scrollView
    }
  }

  /// Fix the flickering of a ScrollView inside a NavigationView
  /// with chance to setup the nested ScrollView inside the closure.
  /// - Parameter configurator: The configuration of the ScrollView.
  /// - Returns: The fixed ScrollView.
  func fixFlickering<T: View>(
    @ViewBuilder configurator: @escaping (ScrollView<AnyView>)
      -> T)
    -> some View
  {
    GeometryReader { geometryWithSafeArea in
      GeometryReader { _ in
        configurator(ScrollView<AnyView>(self.axes, showsIndicators: self.showsIndicators) {
          AnyView(VStack {
            self.content
          }
          .padding(.top, geometryWithSafeArea.safeAreaInsets.top)
          .padding(.bottom, geometryWithSafeArea.safeAreaInsets.bottom)
          .padding(.leading, geometryWithSafeArea.safeAreaInsets.leading)
          .padding(.trailing, geometryWithSafeArea.safeAreaInsets.trailing))
        })
      }
      .edgesIgnoringSafeArea(.all)
    }
  }
}
