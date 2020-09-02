//
//  WideRotationView.swift
//  ikalendar2
//
//  Created by Tianwei Zhang on 8/31/20.
//  Copyright © 2020 Tianwei Zhang. All rights reserved.
//

import SwiftUI

struct WideRotationView: View {
    
    @EnvironmentObject var env: Data
    
    @State private var selectedMode = UserDefaults.standard.integer(forKey: Constants.USERDEFAULTS_KEY_DEFAULTMODE)
    @State var showingSettings = false
    
    var body: some View {
        
        NavigationView {
            
            // MARK: First Navigation View
            
            VStack {
                
                ForEach(0 ..< Constants.MODE_SHORT_NAME.count) { idx in
                    
                    HStack {
                        Button(action: {
                            self.selectedMode = idx
                        }) {
                            HStack(spacing: 16) {
                                Image(Constants.MODE_IMG_FILN[idx])
                                    .renderingMode(.original)
                                    .resizable()
                                    .scaledToFit()
                                    .shadow(radius: 5)
                                    .frame(width: 30)
                                
                                Text(Constants.MODE_TITLE[idx])
                                    .font(.system(.title, design: .rounded))
                                    .fontWeight(.semibold)
                                Spacer()
                            }
                            .padding()
                            .offset(x: -10)
                            .foregroundColor(.primary)
                            .background(self.selectedMode == idx ? Color(UIColor.systemGray4) : .clear)
                            .cornerRadius(10)
                        }
                        .animation(.spring())
                        
                    }
                    
                }
                Spacer()
            }
            .padding(.top,      40)
            .padding(.leading,  10)
            .padding(.trailing, 10)
            .navigationBarTitle("Mode")
            .navigationBarItems(
                leading:
                Button(action: {
                    self.showingSettings.toggle()
                }) {
                    Image(systemName: "gear")
                        .foregroundColor(.primary)
                        .font(.system(size: 18, weight: .medium))
                        .shadow(radius: 5)
                        .frame(width: 25)
                }
                .sheet(isPresented: $showingSettings) {
                    SettingsView()
                },
                
                trailing:
                Button(action: {
                    self.env.getRotations()
                }) {
                    Image(systemName: "arrow.2.circlepath.circle")
                        .foregroundColor(.primary)
                        .font(.system(size: 18, weight: .medium))
                        .shadow(radius: 5)
                        .frame(width: 25)
                }
                
            )
            
            // MARK: Second Content View
            
            if env.loadingStatus == .loading {
                InfoScreenView()
                    .navigationBarTitle(Text("Loading..."))
                
            } else if env.loadingStatus == .failure {
                InfoScreenView()
                    .navigationBarTitle(Text("Error"))
                
            } else {
                WideRotationItemsView(rotations: getRotationArray(for: selectedMode))
                    .navigationBarTitle(Text(Constants.MODE_TITLE[selectedMode]))
                    .navigationBarItems(
                        trailing:
                        Image(Constants.MODE_IMG_FILN[self.selectedMode])
                            .renderingMode(.original)
                            .resizable()
                            .scaledToFit()
                            .shadow(radius: 5)
                            .frame(width: 25)
                )
            }
            
        }
        
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

struct WideRotationView_Previews: PreviewProvider {
    static var previews: some View {
        WideRotationView()
            .environmentObject(Data(isForTest: true))
            .preferredColorScheme(.light)
    }
}
