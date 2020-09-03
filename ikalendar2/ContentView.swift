//
//  ContentView.swift
//  ikalendar2
//
//  Created by Tianwei Zhang on 5/9/20.
//  Copyright © 2020 Tianwei Zhang. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    @Environment(\.horizontalSizeClass) var horizontalSizeClass
    
    @EnvironmentObject var env: Env
    
    var body: some View {
        
        Group {
            
            // Compact Size Class
            if horizontalSizeClass == .compact {
                RotationView()
//                    .environmentObject(self.env)
                
            }
                
                // Regular Size Class
            else {
                WideRotationView()
//                    .environmentObject(self.env)
            }
        }
        .sheet(isPresented: $env.isOnboardingPresented) {
            OnboardingView()
                .environmentObject(self.env)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        RotationView()
            .environmentObject(Env(isForTest: true))
    }
}
