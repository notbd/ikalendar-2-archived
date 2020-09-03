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
    
    @Environment(\.colorScheme) var colorScheme
    
    @EnvironmentObject var env: Env
    
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
                            Picker("Mode", selection: self.$env.selectedMode) {
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
                .navigationBarTitle(Text(Constants.MODE_TITLE[self.env.selectedMode]))
                .navigationBarItems(
                    leading:
                    Button(action: {
                        self.env.getRotations()
                        self.changeSectionHeaderBackgroundColor()
                    }) {
                        HStack {
                            Image(Constants.MODE_IMG_FILN[self.env.selectedMode])
                                .renderingMode(.original)
                                .resizable()
                                .scaledToFit()
                                .shadow(radius: 5)
                                .frame(width: Constants.MODE_ICON_SIDE)
                            Spacer()
                        }
                    }
                    .frame(width: Constants.TAPPABLE_AREA_MIN_SIDE, height: Constants.TAPPABLE_AREA_MIN_SIDE),
                    
                    trailing:
                    Button(action: {
                        self.env.isSettingsPresented.toggle()
                    }) {
                        HStack {
                            Spacer()
                            Image(systemName: "gear")
                                .foregroundColor(.primary)
                                .font(.system(size: Constants.SETTINGS_GEAR_SIZE, weight: .medium))
                                .shadow(radius: 5)
                        }
                    }
                    .frame(width: Constants.TAPPABLE_AREA_MIN_SIDE, height: Constants.TAPPABLE_AREA_MIN_SIDE)
                    .sheet(isPresented: self.$env.isSettingsPresented) {
                        SettingsView().environmentObject(self.env)
//                        OnboardingView()
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
        
        switch(self.env.selectedMode) {
            
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
            .environmentObject(Env(isForTest: true))
            .preferredColorScheme(.light)
    }
}
