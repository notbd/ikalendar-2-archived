//
//  RotationView.swift
//  ikalendar2
//
//  Created by Tianwei Zhang on 5/9/20.
//  Copyright © 2020 Tianwei Zhang. All rights reserved.
//

import SwiftUI

struct RotationView: View {
    
    @State private var selectedMode = UserDefaults.standard.integer(forKey: Constants.USERDEFAULTS_KEY_DEFAULTMODE)
    
    var modeName = ["Turf", "Ranked", "League"]
    var modeTitle = ["Regular Battle", "Ranked Battle", "League Battle"]
    var modeImgName = ["turf_small", "ranked_small", "league_small"]
    
    @EnvironmentObject var env: Data
    
    var body: some View {
        
        NavigationView {
            
            List {
                
                // Mode Picker
                Picker("Mode", selection: $selectedMode) {
                    ForEach(0 ..< modeName.count) { index in
                        Text(self.modeName[index])
                            .tag(index)
                    }
                }.pickerStyle(SegmentedPickerStyle())
                
                // Rotations
                contentFor(mode: selectedMode)
                
            }
            .navigationBarTitle(Text(modeTitle[selectedMode]))
            .navigationBarItems(
                leading:
                Button(action: {self.env.getRotations()}) {
                    Image(modeImgName[selectedMode])
                        .renderingMode(.original)
                        .resizable()
                        .scaledToFit()
                        .shadow(radius: 5)
                        .frame(width: 25)
                }
            ).onAppear {
                self.env.getRotations()
            }
        }

    }
    
    func contentFor(mode: Int) -> some View {
        switch(mode) {
        case 0:
            return RotationItems(rotations: self.env.catalog.regular)
        case 1:
            return RotationItems(rotations: self.env.catalog.ranked)
        case 2:
            return RotationItems(rotations: self.env.catalog.league)
        default:
            return RotationItems(rotations: self.env.catalog.regular)
        }
    }
}

struct RotationView_Previews: PreviewProvider {
    static var previews: some View {
        RotationView()
    }
}
