//
//  RotationView.swift
//  ikalendar2
//
//  Created by Tianwei Zhang on 5/9/20.
//  Copyright © 2020 Tianwei Zhang. All rights reserved.
//

import SwiftUI
import UIKit

struct RotationView: View {
    
    @State private var selectedMode = UserDefaults.standard.integer(forKey: Constants.USERDEFAULTS_KEY_DEFAULTMODE)
    
    var modeName = ["Regular", "Ranked", "League"]
    var modeTitle = ["Regular Battle", "Ranked Battle", "League Battle"]
    var modeImgName = ["turf_small", "ranked_small", "league_small"]
    
    @EnvironmentObject var env: Data
    
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        
        NavigationView {
            
            Group {
                
                if env.loadingStatus != .loaded {
                    InfoScreenView()
                }
                    
                else {
                    
                    List {
                        
                        // Mode Picker
                        Picker("Mode", selection: $selectedMode) {
                            ForEach(0 ..< modeName.count) { index in
                                Text(self.modeName[index])
                                    .tag(index)
                            }
                        }.pickerStyle(SegmentedPickerStyle())
                        
                        // Rotations
                        renderRotationItemsView()
                        
                    }
                }
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
            )
        }
        .onAppear {
            self.changeSectionHeaderBackgroundColor()
        }
        
    }
    
    func changeSectionHeaderBackgroundColor() {
        UITableViewHeaderFooterView.appearance().tintColor = colorScheme == .dark ? UIColor.black : UIColor.white
    }
    
    func renderRotationItemsView() -> some View {
        
        // All nil cases are trivial since already handled in earlier Views
        
        guard let catalog = self.env.catalog else {
            return RotationItemsView(rotations: [])         // nil
        }
        
        switch(selectedMode) {
            
        case 1:     // ranked
            if let rotationArray = catalog.ranked {
                return RotationItemsView(rotations: rotationArray)
            } else {
                return RotationItemsView(rotations: [])     // nil
            }
            
        case 2:     // league
            if let rotationArray = catalog.league {
                return RotationItemsView(rotations: rotationArray)
            } else {
                return RotationItemsView(rotations: [])     // nil
            }
            
        default:    // regular
            if let rotationArray = catalog.regular {
                return RotationItemsView(rotations: rotationArray)
            } else {
                return RotationItemsView(rotations: [])     // nil
            }
        }
    }
}

struct RotationView_Previews: PreviewProvider {
    static var previews: some View {
        RotationView()
            .environmentObject(Data(isForTest: true))
            .preferredColorScheme(.light)
    }
}
