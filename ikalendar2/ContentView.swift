//
//  ContentView.swift
//  ikalendar2
//
//  Created by Tianwei Zhang on 5/9/20.
//  Copyright © 2020 Tianwei Zhang. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    @EnvironmentObject var env: Env
    
    @Environment(\.horizontalSizeClass) var horizontalSizeClass
    
//    @State private var selectedMode         = UserDefaults.standard.integer(forKey: Constants.USERDEFAULTS_KEY_DEFAULTMODE)
//    @State private var isSettingsPresented  = false
    
    var body: some View {
        
        Group {
            
            // Compact Size Class
            if horizontalSizeClass == .compact {
//                RotationView(selectedMode: $selectedMode, isSettingsPresented: $isSettingsPresented)
                RotationView()
            }
                
            // Regular Size Class
            else {
//                WideRotationView(selectedMode: $selectedMode, isSettingsPresented: $isSettingsPresented)
                WideRotationView()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(Env(isForTest: true))
    }
}
