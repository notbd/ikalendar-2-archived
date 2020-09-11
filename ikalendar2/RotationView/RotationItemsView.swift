//
//  RotationItemsView.swift
//  ikalendar2
//
//  Created by Tianwei Zhang on 8/22/20.
//  Copyright © 2020 Tianwei Zhang. All rights reserved.
//

import SwiftUI

struct RotationItemsView: View {
    
    var rotations: [Rotation] = []
    var width: CGFloat
    
    init(width: CGFloat) {
        self.width = width
    }
    
    init(rotations: [Rotation], width: CGFloat) {
        self.rotations = rotations
        self.width = width
    }
    
    var body: some View {
        
        ForEach (0 ..< self.rotations.count, id: \.self) { idx in
            RotationItem(rotation: self.rotations[idx], index: idx, parentWidth: self.width)
        }
        
    }
}

struct RotationItemsView_Previews: PreviewProvider {
    static var previews: some View {
        RotationView()
            .environmentObject(Env(isForTest: true))
            .preferredColorScheme(.dark)
    }
}
