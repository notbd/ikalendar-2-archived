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
    
    var body: some View {
        
        ForEach (0 ..< rotations.count) { idx in
            RotationItem(rotation: self.rotations[idx], index: idx)
        }
        
    }
}

struct RotationItemsView_Previews: PreviewProvider {
    static var previews: some View {
        RotationView()
        .environmentObject(Data(isForTest: true))
            .preferredColorScheme(.dark)
    }
}
