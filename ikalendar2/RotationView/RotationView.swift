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
    
    @EnvironmentObject var env: Data
    
    @Environment(\.colorScheme) var colorScheme
    
    @State private var selectedMode = UserDefaults.standard.integer(forKey: Constants.USERDEFAULTS_KEY_DEFAULTMODE)
    @State var showingSettings = false

    
    var body: some View {
        
        GeometryReader { geometry in
            
            NavigationView {
                
                Group {
                    
                    if self.env.loadingStatus != .loaded {
                        InfoScreenView()
                    }
                        
                    else {
                        
                        List {
                            
                            // Mode Picker
                            Picker("Mode", selection: self.$selectedMode) {
                                ForEach(0 ..< Constants.MODE_SHORT_NAME.count) { index in
                                    Text(Constants.MODE_SHORT_NAME[index])
                                        .tag(index)
                                }
                            }
                            .pickerStyle(SegmentedPickerStyle())
                            
                            // Rotations
                            self.renderRotationItemsView(width: geometry.size.width)
                            
                        }
                    }
                }
                .navigationBarTitle(Text(Constants.MODE_TITLE[self.selectedMode]))
                .navigationBarItems(
                    leading:
                    Button(action: {
                        self.env.getRotations()
                        self.changeSectionHeaderBackgroundColor()
                    }) {
                        Image(Constants.MODE_IMG_FILN[self.selectedMode])
                            .renderingMode(.original)
                            .resizable()
                            .scaledToFit()
                            .shadow(radius: 5)
                            .frame(width: 25)
                    },
                    
                    trailing:
                    Button(action: {
                        self.showingSettings.toggle()
                    }) {
                        Image(systemName: "gear")
                            .foregroundColor(.primary)
                            .font(.system(size: 18, weight: .medium))
                            .shadow(radius: 5)
                            .frame(width: 25)
                    }
                    .sheet(isPresented: self.$showingSettings) {
                        SettingsView()
                    }
                )
            }
            .onAppear {
                self.changeSectionHeaderBackgroundColor()
            }
        }
        
    }
    
    func changeSectionHeaderBackgroundColor() {
        UITableViewHeaderFooterView.appearance().tintColor =
            colorScheme == .dark ? UIColor.black : UIColor.white
//            colorScheme == .dark ? UIColor.clear.withAlphaComponent(0.9) : UIColor.clear.withAlphaComponent(0.1)
//            UIColor.clear.withAlphaComponent(0.1)
//            .clear
    }
    
    func renderRotationItemsView(width: CGFloat) -> some View {
        
        // All nil cases are trivial since already handled in earlier Views
        
        guard let catalog = self.env.catalog else {
            return RotationItemsView(rotations: [], width: width)         // nil
        }
        
        switch(selectedMode) {
            
        case 1:     // ranked
            if let rotationArray = catalog.ranked {
                return RotationItemsView(rotations: rotationArray, width: width)
            } else {
                return RotationItemsView(rotations: [], width: width)     // nil
            }
            
        case 2:     // league
            if let rotationArray = catalog.league {
                return RotationItemsView(rotations: rotationArray, width: width)
            } else {
                return RotationItemsView(rotations: [], width: width)     // nil
            }
            
        default:    // regular
            if let rotationArray = catalog.regular {
                return RotationItemsView(rotations: rotationArray, width: width)
            } else {
                return RotationItemsView(rotations: [], width: width)     // nil
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
