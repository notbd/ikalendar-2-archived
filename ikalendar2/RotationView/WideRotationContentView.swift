//
//  WideRotationContentView.swift
//  ikalendar2
//
//  Created by Tianwei Zhang on 8/31/20.
//  Copyright © 2020 Tianwei Zhang. All rights reserved.
//

import SwiftUI

struct WideRotationContentView: View {

    var rotations: [Rotation]
    
    var body: some View {
        Form {
            ForEach (0 ..< rotations.count) { idx in
                RotationItem(rotation: self.rotations[idx], index: idx)
            }
        }
    }
}

//struct WideRotationContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        WideRotationContentView(title: "Test1", content: "Test2")
//        WideRotationContentView()
//    }
//}
