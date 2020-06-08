//
//  RotationView.swift
//  ikalendar2
//
//  Created by Tianwei Zhang on 5/9/20.
//  Copyright © 2020 Tianwei Zhang. All rights reserved.
//

import SwiftUI

struct RotationView: View {
    
    @State private var selectedMode = 1
    
    var mode = ["Turf", "Ranked", "League"]
    var modeTitle = ["Regular Battle", "Ranked Battle", "League Battle"]
    var modeImgName = ["turf_small", "ranked_small", "league_small"]
    
    var rotations:[Rotation]
    
    var body: some View {
        
        NavigationView {
            
                List {
                    
                    // Mode Picker
                    Picker("Mode", selection: $selectedMode) {
                        ForEach(0 ..< mode.count) { index in
                            Text(self.mode[index])
                                .tag(index)
                        }
                    }.pickerStyle(SegmentedPickerStyle())
                    
                    // Rotations
                    ForEach (self.rotations) { rotation in
                        RotationItem(rotation: rotation)
                    }
                    
                }
                .navigationBarTitle(Text(modeTitle[selectedMode]))
                .navigationBarItems(
                    leading: Image(modeImgName[selectedMode])
                                .resizable()
                                .scaledToFit()
                                .shadow(radius: 5)
                                .frame(width: 25))
            }
            
    }
}

struct RotationView_Previews: PreviewProvider {
    static var previews: some View {
        RotationView(rotations: rotationData)
    }
}
