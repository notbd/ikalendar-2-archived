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
    
    init() {

        let largeTitleFontSize: CGFloat = 34
        let titleTextFontSize: CGFloat = 17
    
        // Here we get San Francisco with the desired weight
        let systemLargeTitleFont = UIFont.systemFont(ofSize: largeTitleFontSize, weight: .bold)
        let systemTitleTextFont = UIFont.systemFont(ofSize: titleTextFontSize, weight: .bold)

        // Will be SF Compact or standard SF in case of failure.
        let largeTitleFont, titleTextFont: UIFont

        if let descriptor = systemLargeTitleFont.fontDescriptor.withDesign(.rounded) {
            largeTitleFont = UIFont(descriptor: descriptor, size: largeTitleFontSize)
        } else {
            largeTitleFont = systemLargeTitleFont
        }

        if let descriptor = systemTitleTextFont.fontDescriptor.withDesign(.rounded) {
            titleTextFont = UIFont(descriptor: descriptor, size: titleTextFontSize)
        } else {
            titleTextFont = systemTitleTextFont
        }

        UINavigationBar.appearance().largeTitleTextAttributes = [
            .font : largeTitleFont]


        UINavigationBar.appearance().titleTextAttributes = [
            .font : titleTextFont]
    

    }
    
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
        ContentView().environmentObject(Data())
    }
}
