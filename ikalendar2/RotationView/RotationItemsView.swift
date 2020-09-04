//
//  RotationItemsView.swift
//  ikalendar2
//
//  Created by Tianwei Zhang on 8/22/20.
//  Copyright © 2020 Tianwei Zhang. All rights reserved.
//

import SwiftUI

struct RotationItemsView: View {
    
    var rotations: [Rotation]
    var width: CGFloat
    var height: CGFloat
    
    var body: some View {
        
        ForEach (0 ..< self.rotations.count, id: \.self) { idx in
            RotationItem(rotation: self.rotations[idx], index: idx, parentWidth: self.width, parentHeight: self.height)
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
