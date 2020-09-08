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
    
    @State var isTempOnboardingPresented = false
    
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
                SettingsFooterSizedText {
                    Text(   """
                            • When auto-refresh is on, data will keep being updated to the latest rotation schedule
                            • There might be a slight delay due to the data api restriction
                            • You can always manually refresh by tapping the mode icon
                            """)
                }
                )
            {
                Toggle(isOn: self.$env.isAutoRefreshEnabled) {
                    SettingsBodySizedText {
                        Text("Auto Refresh")
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
                    self.isTempOnboardingPresented.toggle()
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
