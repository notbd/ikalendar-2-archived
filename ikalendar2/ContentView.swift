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
    
    @State private var isModalPresented    = false
    @State private var OnboardInsteadOfWhatsNew = true
    
    @State private var isModalSetUpFinished   = false
    
    @AppStorage(Constants.USERDEFAULTS_KEY_ISFIRSTLAUNCH_BOOL) var isFirstLaunch: Bool = true
    @AppStorage(Constants.USERDEFAULTS_KEY_LASTVERSION_STRING) var lastVersion: String = "2.0"
    
    let currentVersionOp  = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String
    
    var body: some View {
        
        NavigationView {
            
            switch horizontalSizeClass {
            
            case .compact:
                RotationView()
                
            default:
                WideRotationView()
                
            }
            
        }
        .accentColor(.primary)
        .onReceive(env.refreshTimer) { _ in

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
        .sheet(isPresented: $isModalPresented) {
            if OnboardInsteadOfWhatsNew {
                OnboardingView()
            } else {
                WhatsNewView()
            }
        }
    }
    
    func greetingsModalsSetup() {
        
        // Only run once every app cycle
        if isModalSetUpFinished {
            return
        }
        isModalSetUpFinished = true
        
        // Setup whatsnew presenting and userdefaults->lastVersion
        var isNewVersion: Bool {
            if let currentVersion = currentVersionOp {
                return currentVersion > lastVersion
            } else {
                return false
            }
        }
        
        // Onboarding higher priority than What's New
        OnboardInsteadOfWhatsNew = isFirstLaunch
        
        // Activate modal
        isModalPresented = isFirstLaunch || isNewVersion

        // Write new AppStorage value
        isFirstLaunch = false
        lastVersion = currentVersionOp ?? "2.0"
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        RotationView()
            .environmentObject(Env(isForTest: true))
    }
}
