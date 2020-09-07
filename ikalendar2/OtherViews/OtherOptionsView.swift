//
//  OtherOptionsView.swift
//  ikalendar2
//
//  Created by Tianwei Zhang on 9/6/20.
//  Copyright © 2020 Tianwei Zhang. All rights reserved.
//

import SwiftUI

struct OtherOptionsView: View {
    
    @State var isTempOnboardingPresented = false
    
    @State private var isColorSchemeAutomatic = true
    @State private var darkModeToggleModel = DarkModeToggleModel()
    
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

struct DarkModeToggleModel {
    var isDark: Bool = true {
        didSet {
            SceneDelegate.shared?.window!.overrideUserInterfaceStyle = isDark ? .dark : .light
        }
    }
}

struct OtherOptionsView_Previews: PreviewProvider {
    static var previews: some View {
        OtherOptionsView()
    }
}
