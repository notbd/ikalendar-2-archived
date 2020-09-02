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
    @Environment(\.horizontalSizeClass) var horizontalSizeClass
    
    @State private var tabSelection = 0
    
    var body: some View {
        
        Group {
            
            // Compact Size Class
            if horizontalSizeClass == .compact {
                RotationView()
            }
                
            // Regular Size Class
            else {
                WideRotationView()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(Data(isForTest: true))
    }
}
