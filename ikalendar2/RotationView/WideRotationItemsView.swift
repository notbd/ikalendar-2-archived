//
//  WideRotationItemsView.swift
//  ikalendar2
//
//  Created by Tianwei Zhang on 8/31/20.
//  Copyright © 2020 Tianwei Zhang. All rights reserved.
//

import SwiftUI

struct WideRotationItemsView: View {
    
    var rotations: [Rotation]
    
    var body: some View {
        Form {
            ForEach (0 ..< rotations.count) { idx in
                WideRotationItem(rotation: self.rotations[idx], index: idx)
            }
        }
    }
}

struct WideRotationItemsView_Previews: PreviewProvider {
    static var previews: some View {
        WideRotationView()
            .environmentObject(Data(isForTest: true))
            .preferredColorScheme(.light)
    }
}
