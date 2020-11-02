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
    
    var body: some View {
            
        GeometryReader { geometry in
                
            Group {
                
                if self.env.loadingStatus == .loading || self.env.loadingStatus == .failure {
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
                        .onChange(of: selectedModeEnv.selectedMode) { newValue in
                            simpleHapticLight()
                        }
                        
                        // Rotations
                        self.renderRotationItemsView(width: geometry.size.width)
                        
                    }
//                    .listSeparatorStyle(.none)
                    .listStyle(InsetGroupedListStyle())
                }
            }
            .navigationBarTitle(Text(Constants.MODE_TITLE[self.selectedModeEnv.selectedMode]))
            .navigationBarItems(
                // MARK: Refresh Button
                leading:
                HStack {
                    Button(action: {
                        simpleHapticLight()
                        self.env.loadRotations()
                    }) {
                        HStack {
                            // MARK: Manual Refresh Indicator
                            if self.env.loadingStatus == .loading {
                                ProgressView()
                            }
                            
                            // MARK: Auto Refresh Indicator
                            else if self.env.loadingStatus == .duringAutoRefresh {
                                Image(systemName: "ellipsis")
                                    .foregroundColor(.primary)
                            }
                            
                            // MARK: Mode Image
                            else {
                                Image(Constants.MODE_IMG_FILN[self.selectedModeEnv.selectedMode])
                                    .renderingMode(.original)
                                    .resizable()
                                    .scaledToFit()
                                    .shadow(radius: 5)
                                    .frame(width: Constants.MODE_ICON_SIDE)
                            }
                            
                        }
                        .frame(width: Constants.TAPPABLE_AREA_MIN_SIDE, height: Constants.TAPPABLE_AREA_MIN_SIDE)
                        .background(
                            Color(UIColor.systemGray4)
                                .opacity(self.colorScheme == .dark ? 0.3 : 0.2)
                                .cornerRadius(5)
                        )
                    }
                }
                ,
                
                // MARK: Settings Button
                trailing:
                    Button(action: {
                        simpleHapticLight()
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
                    .fullScreenCover(
                        isPresented:
                            self.$isSettingsPresented
                    ) {
                        SettingsView()
                            .environmentObject(self.env)
                    }
            )
        }
    }
    
    func renderRotationItemsView(width: CGFloat) -> some View {
        
        // All nil cases are trivial since already handled in earlier Views
        
        guard let catalog = self.env.catalog else {
            return RotationItemsView(width: width)         // nil
        }
        
        switch(self.selectedModeEnv.selectedMode) {
            
        case 1:     // ranked
            if let rotationArray = catalog.ranked {
                return RotationItemsView(rotations: rotationArray, width: width)
            } else {
                return RotationItemsView(width: width)     // nil
            }
            
        case 2:     // league
            if let rotationArray = catalog.league {
                return RotationItemsView(rotations: rotationArray, width: width)
            } else {
                return RotationItemsView(width: width)     // nil
            }
            
        default:    // regular
            if let rotationArray = catalog.regular {
                return RotationItemsView(rotations: rotationArray, width: width)
            } else {
                return RotationItemsView(width: width)     // nil
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
