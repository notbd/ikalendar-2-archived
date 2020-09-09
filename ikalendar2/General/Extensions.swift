//
//  Extensions.swift
//  ikalendar2
//
//  Created by Tianwei Zhang on 9/8/20.
//  Copyright © 2020 Tianwei Zhang. All rights reserved.
//

import SwiftUI

extension Binding {
    func myAddActionOnChange(_ handler: @escaping () -> Void) -> Binding<Value> {
        return Binding(
            get: { self.wrappedValue },
            set: { selection in
                self.wrappedValue = selection
                handler()
        })
    }
}
