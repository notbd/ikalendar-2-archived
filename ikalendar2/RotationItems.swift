//
//  RotationItems.swift
//  ikalendar2
//
//  Created by Tianwei Zhang on 8/22/20.
//  Copyright © 2020 Tianwei Zhang. All rights reserved.
//

import SwiftUI

struct RotationItems: View {
    
    var rotations: [Rotation]
    
    var body: some View {
        ForEach (rotations, id: \.self) { rotation in
            RotationItem(rotation: rotation)
        }
    }
}

struct RotationItems_Previews: PreviewProvider {
    static var previews: some View {
        RotationView()
        .environmentObject(Data(isForTest: true))
        .environment(\.colorScheme, .dark)
    }
}
