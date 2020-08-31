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
    
    var modeName = ["Regular", "Ranked", "League"]
    var modeTitle = ["Regular Battle", "Ranked Battle", "League Battle"]
    var modeImgName = ["turf_small", "ranked_small", "league_small"]
    
    var body: some View {
        
        NavigationView {
            
            // MARK: First Navigation View
            
            List {
                
                ForEach(0 ..< modeName.count) { idx in
                    NavigationLink(
                        destination: WideRotationItemsView(rotations: self.getRotationArray(for: idx))
                            .navigationBarTitle(Text(self.modeTitle[idx]))
                    ) {
                        HStack {
                            Image(self.modeImgName[idx])
                                .renderingMode(.original)
                                .resizable()
                                .antialiased(true)
                                .scaledToFit()
                                .shadow(radius: 5)
                                .frame(width: 35, height: 35)
                            
                            Text(self.modeName[idx])
                        }
                    }
                }
                
            }
            .navigationBarTitle("Mode")
            
            // MARK: Second Content View
            
            if env.loadingStatus == .loading {
                InfoScreenView()
                    .navigationBarTitle(Text("Loading..."))
                
            } else if env.loadingStatus == .failure {
                InfoScreenView()
                    .navigationBarTitle(Text("Error"))
                
            } else {
                WideRotationItemsView(rotations: getRotationArray(for: selectedMode))
                    .navigationBarTitle(Text(modeTitle[selectedMode]))
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
            if let rotationArray = catalog.ranked {
                return rotationArray
            } else {
                return []
            }
        case 2:     // league
            if let rotationArray = catalog.league {
                return rotationArray
            } else {
                return []
            }
        default:    // regular
            if let rotationArray = catalog.regular {
                return rotationArray
            } else {
                return []
            }
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
