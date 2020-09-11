//
//  OtherOptionsView.swift
//  ikalendar2
//
//  Created by Tianwei Zhang on 9/6/20.
//  Copyright © 2020 Tianwei Zhang. All rights reserved.
//

import SwiftUI

struct OtherOptionsView: View {
    
    @EnvironmentObject var env: Env
    
    @State private var isTempOnboardingPresented = false
    
    @State private var autoRefreshNoteStatus: Bool = UserDefaults.standard.bool(forKey: Constants.USERDEFAULTS_KEY_AUTOREFRESH_BOOL)
    
//    @State private var isColorSchemeAutomatic = true
//    @State private var darkModeToggleModel = DarkModeToggleModel()
    
    var body: some View {
        Form {
            
//            Section(
//                header:
//                SettingsHeaderSizedText {
//                    Text("Appearance")
//                }
//                .padding(.top, 32)
//                )
//            {
////                Toggle(isOn: $isColorSchemeAutomatic) {
////                    SettingsBodySizedText {
////                        Text("跟随系统")
////                    }
////                }
//                Toggle(isOn: $darkModeToggleModel.isDark) {
//                    SettingsBodySizedText {
//                        Text("Turn on dark mode")
//                    }
//                }
//            }
            
            Section(
                header:
                SettingsHeaderSizedText {
                    Text("Data Refreshing")
                }
                .padding(.top, 32)
                ,
                footer:
                VStack(alignment: .leading) {
                    SettingsFooterSizedText {
                        Text(self.autoRefreshNoteStatus ? Constants.DATA_REFRESH_INFO_PART1_ON : Constants.DATA_REFRESH_INFO_PART1_OFF)
                    }
                    .padding(.bottom, 5)
                    SettingsTinySizedText {
                        Text(self.autoRefreshNoteStatus ? Constants.DATA_REFRESH_INFO_PART2_ON : Constants.DATA_REFRESH_INFO_PART2_OFF)
                    }
                }
                )
            {
                Toggle(isOn: self.$env.isAutoRefreshEnabled.myAddActionOnChange(toggleAutoRefreshNoteStatus)) {
                    SettingsBodySizedText {
                        Text("Smart Refresh")
                    }
                }
            }
            
            Section(
                header:
                SettingsHeaderSizedText {
                    Text("What's New")
                }
                )
            {
                Button(action: {
                    simpleHapticLight()
                    self.isTempOnboardingPresented = true
                }) {
                    SettingsBodySizedText {
                        Text("Onboarding Intro")
                            .foregroundColor(.primary)
                    }
                }
                .sheet(isPresented: self.$isTempOnboardingPresented) {
                    OnboardingView()
                }
            }
            
            Section(
                header:
                SettingsHeaderSizedText {
                    Text("Others")
                }
                )
            {
                Button(action: {}) {
                    SettingsBodySizedText {
                        HStack {
                            Image(systemName: "paintbrush.fill")
                            Text("In Development..")
                        }
                        .foregroundColor(.gray)
                    }
                }
                .disabled(true)
            }
        }
        .navigationBarTitle("Other Options", displayMode: .inline)
    }
    
    func toggleAutoRefreshNoteStatus() {
        autoRefreshNoteStatus.toggle()
    }
}

//struct DarkModeToggleModel {
//    var isDark: Bool = true {
//        didSet {
//            SceneDelegate.shared?.window!.overrideUserInterfaceStyle = isDark ? .dark : .light
//        }
//    }
//}

struct OtherOptionsView_Previews: PreviewProvider {
    static var previews: some View {
        OtherOptionsView()
    }
}
