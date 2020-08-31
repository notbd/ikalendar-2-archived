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
    
    @State private var selectedMode = 0
    
    var modeName = ["Regular", "Ranked", "League"]
    var modeTitle = ["Regular Battle", "Ranked Battle", "League Battle"]
    var modeImgName = ["turf_small", "ranked_small", "league_small"]
    
    var body: some View {
        NavigationView {
            List {
                NavigationLink(
                    destination: WideRotationContentView()
                ) {
                    HStack {
                        Image("turf_small")
                            .renderingMode(.original)
                            .resizable()
                            .antialiased(true)
                            .scaledToFit()
                            .shadow(radius: 5)
                            .frame(width: 35, height: 35)
                        
                        Text("Regular")
                    }
                }
                
                NavigationLink(
                    destination: WideRotationContentView()
                ) {
                    HStack {
                        Image("ranked_small")
                            .renderingMode(.original)
                            .resizable()
                            .antialiased(true)
                            .scaledToFit()
                            .shadow(radius: 5)
                            .frame(width: 35, height: 35)
                        Text("Ranked")
                    }
                }
                
                NavigationLink(
                    destination: WideRotationContentView()
                ){
                    HStack {
                        Image("league_small")
                            .renderingMode(.original)
                            .resizable()
                            .antialiased(true)
                            .scaledToFit()
                            .shadow(radius: 5)
                            .frame(width: 35, height: 35)
                        Text("League")
                    }
                }
                
            }
                .navigationBarTitle("Mode")
            if env.loadingStatus != .loaded {
//                RotationItems(rotations: (self.env.catalog?.ranked!)!)
//                .navigationBarTitle("Ranked Battle")
                InfoScreenView()
            }
            
            
            
        }
        
    }
}

struct WideRotationView_Previews: PreviewProvider {
    static var previews: some View {
        WideRotationView()
    }
}
