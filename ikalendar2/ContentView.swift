//
//  ContentView.swift
//  ikalendar2
//
//  Created by Tianwei Zhang on 5/9/20.
//  Copyright © 2020 Tianwei Zhang. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    @Environment(\.horizontalSizeClass) private var horizontalSizeClass
    
    @EnvironmentObject private var env: Env
    @EnvironmentObject private var selectedModeEnv: SelectedModeEnv
    
    @State private var isOnboardingPresented    = false
    @State private var isWhatsNewPresented      = false
    
    @State private var isGreetingsModalsSetup   = false
    @State private var navigationViewID = UUID()
    
    private let refreshTimer = Timer.publish(every: 10, tolerance: 0.5, on: .main, in: .common).autoconnect()
    
    var body: some View {
        
        NavigationView {
            
            // Compact Size Class
            if horizontalSizeClass == .compact {
                RotationView()
            }
                
            // Regular Size Class
            else {
                WideRotationView()
            }
        }
        .id(self.navigationViewID)
            
        // force go to top when env data change, to deal with the SwiftUI NavView bug
        .onReceive(self.env.objectWillChange) { _ in
            self.navigationViewID = UUID()
        }
        .onReceive(refreshTimer) { _ in

            // if auto-refresh disabled or at during-autoRefresh/failure state
            if !self.env.isAutoRefreshEnabled || self.env.loadingStatus == .duringAutoRefresh ||  self.env.loadingStatus == .failure { return }

//            // TEST
//            let dateFormatter = DateFormatter()
//            dateFormatter.dateFormat = "mmss"
//            let currTimeStr = dateFormatter.string(from: Date())
//
//            if currTimeStr > "0000" {
//                self.env.startAutoRefresh()
//            }
            
            // RUN: refresh if env.nextRefreshTime not nil and currTime past nextRefreshTime
            guard let currRotationEndTime = self.env.currRotationEndTime else { return }
            let currTime = Date()
            if currTime >= currRotationEndTime {
                self.env.startAutoRefresh()
            }
            
        }
        .onAppear {
            self.greetingsModalsSetup()
        }
        .sheet(isPresented: $isOnboardingPresented) {
            OnboardingView()
        }
    }
    
    func greetingsModalsSetup() {
        if !isGreetingsModalsSetup {
            isGreetingsModalsSetup = true
            
            // Setup onboarding presenting and UserDefaults->isFirstLaunch
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
