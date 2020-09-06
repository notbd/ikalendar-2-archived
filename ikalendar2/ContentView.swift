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
    
    @State private var isOnboardingPresented    = false
    @State private var isWhatsNewPresented      = false
    
    @State private var isGreetingsModalsSetup   = false
    
    private let refreshOnTheHourTimer = Timer.publish(every: 1, tolerance: 0.5, on: .main, in: .common).autoconnect()
    
    var body: some View {
        
        Group {
            
            // Compact Size Class
            if horizontalSizeClass == .compact {
                RotationView()
                    .environmentObject(self.env)
            }
                
            // Regular Size Class
            else {
                WideRotationView()
                    .environmentObject(self.env)
            }
        }
        .onReceive(refreshOnTheHourTimer) { _ in
            let dateFormatter = DateFormatter()
            dateFormatter.locale = NSLocale.current
            dateFormatter.dateFormat = "mmss"
            let curr_time_str = dateFormatter.string(from: Date())
            let curr_time_int = Int(curr_time_str) ?? -1
            
            if (curr_time_int == 0) {
                self.env.getRotations()
            }
        }
        .onAppear {
            self.greetingsModalsSetup()
        }
        .sheet(isPresented: $isOnboardingPresented) {
            OnboardingView()
        }
        
        //        .listStyle(GroupedListStyle())
        //        .environment(\.horizontalSizeClass, .regular)
    }
    
    func greetingsModalsSetup() {
        if !isGreetingsModalsSetup {
            isGreetingsModalsSetup = true
            
            // Setup onboarding presenting and userdefaults->isFirstLaunch
            let isFirstLaunch    = UserDefaults.standard.bool(forKey: Constants.USERDEFAULTS_KEY_ISFIRSTLAUNCH_BOOL)
            isOnboardingPresented = isFirstLaunch
            if isFirstLaunch {
                UserDefaults.standard.set(false, forKey: Constants.USERDEFAULTS_KEY_ISFIRSTLAUNCH_BOOL)
            }
            
            // Setup whatsnew presenting and userdefaults->lastVersion
            let lastVersion     = UserDefaults.standard.string(forKey: Constants.USERDEFAULTS_KEY_LASTVERSION_STRING)
            let currentVersion  = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String
            var isNewVersion: Bool {
                if lastVersion != nil && currentVersion != nil {
                    return currentVersion! > lastVersion!
                } else {
                    return false
                }
            }
            isWhatsNewPresented = isNewVersion
            if isNewVersion {
                UserDefaults.standard.set(currentVersion, forKey: Constants.USERDEFAULTS_KEY_LASTVERSION_STRING)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        RotationView()
            .environmentObject(Env(isForTest: true))
    }
}
