//
//  WideRotationView.swift
//  ikalendar2
//
//  Created by Tianwei Zhang on 8/31/20.
//  Copyright © 2020 Tianwei Zhang. All rights reserved.
//

import SwiftUI

struct WideRotationView: View {
    
    @Environment(\.colorScheme) private var colorScheme
    
    @EnvironmentObject private var env: Env
    @EnvironmentObject private var selectedModeEnv: SelectedModeEnv
    
    @State var isSettingsPresented = false
    
    @ViewBuilder
    var body: some View {
        
        // MARK: - First View in NavigationView
        Siderbar(isSettingsPresented: $isSettingsPresented)
        
        // MARK: - Second View in NavigationView
        Group {
            if env.loadingStatus == .loading {
                InfoScreenView()
                    .navigationBarTitle(Text("Loading..."))
                
            } else if env.loadingStatus == .failure {
                InfoScreenView()
                    .navigationBarTitle(Text("Error"))
                
            } else {
                    WideRotationItemsView(rotations: getRotationArray(for: self.selectedModeEnv.selectedMode))
                .navigationBarTitle(Text(Constants.MODE_TITLE[self.selectedModeEnv.selectedMode]))
                
            }
        }
        .navigationBarItems(
            
            // MARK: Mode Icon Refresh Button
            trailing:
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
                            .opacity(self.colorScheme == .dark ? 0.3 : 0.15)
                            .cornerRadius(5)
                    )
                }
            }
    )
        
    }
    
    func getRotationArray(for modeIndex: Int) -> [Rotation] {
        
        // All nil cases are trivial since already handled in earlier Views
        
        guard let catalog = self.env.catalog else {
            return []
        }
        
        switch(modeIndex) {
            
        case 1:     // ranked
            return catalog.ranked ?? []
            
        case 2:     // league
            return catalog.league ?? []
            
        default:    // regular
            return catalog.regular ?? []
        }
    }
    
}
struct Siderbar: View {
    
    @EnvironmentObject private var env: Env
    @EnvironmentObject private var selectedModeEnv: SelectedModeEnv
    
    @Binding var isSettingsPresented: Bool
    
    var body: some View {
        VStack {
            
            ForEach(0 ..< Constants.MODE_SHORT_NAME.count) { idx in
                
                HStack {
                    Button(action: {
                        self.selectedModeEnv.selectedMode = idx
                    }) {
                        HStack(spacing: 16) {
                            Image(Constants.MODE_IMG_FILN[idx])
                                .renderingMode(.original)
                                .resizable()
                                .scaledToFit()
                                .shadow(radius: 5)
                                .frame(width: Constants.MODE_ICON_SIDE)
                            
                            Text(Constants.MODE_TITLE[idx])
                                .font(.system(size: 24, weight: .semibold, design: .rounded))
                                .fontWeight(.semibold)
                            Spacer()
                        }
                        .padding()
                        .offset(x: -10)
                        .foregroundColor(.primary)
                        .background(self.selectedModeEnv.selectedMode == idx ? Color(UIColor.systemGray4) : .clear)
                        .cornerRadius(10)
                    }
                    .animation(.spring())
                }
            }
            
            Spacer()
        }
//        .listStyle(SidebarListStyle())
        .padding(.top,      40)
        .padding(.leading,  10)
        .padding(.trailing, 10)
        .navigationBarTitle("Mode")
        .navigationBarItems(
            
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
                        .opacity(0.2)
                        .cornerRadius(5)
                )
            }
                .sheet(
                    isPresented:
                    self.$isSettingsPresented
                ) {
                    SettingsView()
                        .environmentObject(self.env)
                }
        )
    }
}

struct WideRotationView_Previews: PreviewProvider {
    static var previews: some View {
        WideRotationView()
            .environmentObject(Env(isForTest: true))
            .preferredColorScheme(.light)
    }
}
