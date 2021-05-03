//
//  IkaWidget.swift
//  IkaWidget
//
//  Created by Tianwei Zhang on 4/24/21.
//

import Intents
import SwiftUI
import WidgetKit

/// Main entry point for the widgets.
@main
struct IkaWidgetBundle: WidgetBundle {
  @WidgetBundleBuilder
  var body: some Widget {
    MatchWidget()
    SalmonWidget()
  }
}
