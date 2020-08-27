//
//  ContentView.swift
//  ikalendar2
//
//  Created by Tianwei Zhang on 5/9/20.
//  Copyright © 2020 Tianwei Zhang. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    @EnvironmentObject var env: Data
    
    @State private var tabSelection = 0
    
    var body: some View {
        
        TabView(selection: $tabSelection) {
            
            RotationView()
                .tabItem {
                    VStack {
                        Image(systemName: "calendar")
                            .font(.system(size: 22))
                        Text("Rotations")
                    }
            }.tag(0)
            
            SettingsView()
                .tabItem {
                    VStack {
                        Image(systemName: "gear")
                            .font(.system(size: 22))
                        Text("Settings")
                    }
            }.tag(1)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(Data(isForTest: true))
    }
}
