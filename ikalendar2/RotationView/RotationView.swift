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
    
    @Environment(\.colorScheme) private var colorScheme
    
    @EnvironmentObject private var env: Env
    @EnvironmentObject private var selectedModeEnv: SelectedModeEnv
    
    @State private var isSettingsPresented = false
    
    // Use to re-render NavigationView in order to force go to top
    @State private var navigationViewID = UUID()
    
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
                            Picker("Mode", selection: self.$selectedModeEnv.selectedMode) {
                                ForEach(0 ..< Constants.MODE_SHORT_NAME.count) { index in
                                    Text(Constants.MODE_SHORT_NAME[index])
                                        .tag(index)
                                }
                            }
                            .pickerStyle(SegmentedPickerStyle())
                            
                            // Rotations
                            self.renderRotationItemsView(width: geometry.size.width, height: geometry.size.height)
                            
                        }
                    }
                }
                .navigationBarTitle(Text(Constants.MODE_TITLE[self.selectedModeEnv.selectedMode]))
                .navigationBarItems(
                    
                    // MARK: Refresh Button
                    leading:
                    Button(action: {
                        self.env.getRotations()
                    }) {
                        HStack {
                            Image(Constants.MODE_IMG_FILN[self.selectedModeEnv.selectedMode])
                                .renderingMode(.original)
                                .resizable()
                                .scaledToFit()
                                .shadow(radius: 5)
                                .frame(width: Constants.MODE_ICON_SIDE)
                        }
                        .frame(width: Constants.TAPPABLE_AREA_MIN_SIDE, height: Constants.TAPPABLE_AREA_MIN_SIDE)
                        .background(
                            Color(UIColor.systemGray4)
                                .opacity(self.colorScheme == .dark ? 0.3 : 0.2)
                                .cornerRadius(5)
                        )
                    }
                    // force go to top when env data change, to deal with the SwiftUI NavView bug
                    .onReceive(self.env.objectWillChange) { _ in
                        self.navigationViewID = UUID()
                        self.changeSectionHeaderBackgroundColor()
                    }
                    .onAppear {
                        self.changeSectionHeaderBackgroundColor()
                    }
                    ,
                    
                    // MARK: Settings Button
                    trailing:
                    Button(action: {
                        self.isSettingsPresented = true
                    }) {
                        HStack {
                            Image(systemName: "gear")
                                .foregroundColor(.primary)
                                .font(.system(size: Constants.NAVBAR_SFSYMBOLS_SIZE, weight: .medium))
                                .shadow(radius: 5)
                        }
                        .frame(width: Constants.TAPPABLE_AREA_MIN_SIDE, height: Constants.TAPPABLE_AREA_MIN_SIDE)
                        .background(
                            Color(UIColor.systemGray4)
                                .opacity(self.colorScheme == .dark ? 0.3 : 0.2)
                                .cornerRadius(5)
                        )
                    }
                    .sheet(isPresented:
                        self.$isSettingsPresented
                    ) {
                        SettingsView()
                            .environmentObject(self.env)
                    }
                )
            }
            .id(self.navigationViewID)
        }
        
    }
    
    func changeSectionHeaderBackgroundColor() {
        UITableViewHeaderFooterView.appearance().tintColor =
//            colorScheme == .dark ? UIColor.black : UIColor.white
            colorScheme == .dark ? UIColor.systemGray4.withAlphaComponent(0.5) : UIColor.systemGray4.withAlphaComponent(0.5)
//            UIColor.systemGray4.withAlphaComponent(0.6)
//            .clear
    }
    
    func renderRotationItemsView(width: CGFloat, height: CGFloat) -> some View {
        
        // All nil cases are trivial since already handled in earlier Views
        
        guard let catalog = self.env.catalog else {
            return RotationItemsView(rotations: [], width: width, height: height)         // nil
        }
        
        switch(self.selectedModeEnv.selectedMode) {
            
        case 1:     // ranked
            if let rotationArray = catalog.ranked {
                return RotationItemsView(rotations: rotationArray, width: width, height: height)
            } else {
                return RotationItemsView(rotations: [], width: width, height: height)     // nil
            }
            
        case 2:     // league
            if let rotationArray = catalog.league {
                return RotationItemsView(rotations: rotationArray, width: width, height: height)
            } else {
                return RotationItemsView(rotations: [], width: width, height: height)     // nil
            }
            
        default:    // regular
            if let rotationArray = catalog.regular {
                return RotationItemsView(rotations: rotationArray, width: width, height: height)
            } else {
                return RotationItemsView(rotations: [], width: width, height: height)     // nil
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
