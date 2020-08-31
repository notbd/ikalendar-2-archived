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
                            ForEach(0 ..< Constants.MODE_SHORT_NAME.count) { index in
                                Text(Constants.MODE_SHORT_NAME[index])
                                    .tag(index)
                            }
                        }.pickerStyle(SegmentedPickerStyle())
                        
                        // Rotations
                        renderRotationItemsView()
                        
                    }
                }
            }
            .navigationBarTitle(Text(Constants.MODE_TITLE[selectedMode]))
            .navigationBarItems(
                leading:
                Button(action: {self.env.getRotations()}) {
                    Image(Constants.MODE_IMG_FILN[selectedMode])
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
