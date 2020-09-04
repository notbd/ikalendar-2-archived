//
//  SettingsView.swift
//  ikalendar2
//
//  Created by Tianwei Zhang on 5/9/20.
//  Copyright © 2020 Tianwei Zhang. All rights reserved.
//

import SwiftUI

struct SettingsView: View {
    
    @Environment(\.presentationMode) var presentationMode
    @Environment(\.colorScheme) var colorScheme
    
    @EnvironmentObject var env: Env
    
    @State private var settingsDefaultMode = UserDefaults.standard.integer(forKey: Constants.USERDEFAULTS_KEY_DEFAULTMODE)
    @State var isTempOnboardingPresented = false
    
    var body: some View {
        NavigationView {
            List {
                
                Section(header: Text("Mode displayed when app launches:")) {
                    
                    Picker("Default Mode: ", selection: $settingsDefaultMode) {
                        ForEach(0 ..< Constants.MODE_SHORT_NAME.count) { index in
                            Text(Constants.MODE_SHORT_NAME[index])
                                .tag(index)
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                    .onReceive([self.settingsDefaultMode].publisher.first()) { value in
                        self.saveDefaultMode()
                    }
                }
                
                Section(header: Text("Other options:")) {
                    Button(action: {
                        self.isTempOnboardingPresented.toggle()
                    }) {
                        Text("Show Onboarding Screen")
                            .foregroundColor(.primary)
                    }
                    .sheet(isPresented: self.$isTempOnboardingPresented) {
                        OnboardingView()
                        //                            .environmentObject(self.env)
                    }
                    
                    
                    
                }
                
                Section(
                    header: Text("Acknowledgement"),
                    footer: Text(Constants.COPYRIGHT_INFO)
                        .font(.caption))
                {
                    Button(action: {
                        UIApplication.shared.open(URL(string: Constants.SPLATOON_WEBSITE_URL)!)
                    }) {
                        HStack {
                            Text("Splatoon™ 2").foregroundColor(.primary)
                            Spacer()
                            Text("Official Website").foregroundColor(.secondary)
                            Image(systemName: "globe").foregroundColor(.secondary)
                        }
                        
                    }
                    
                    Button(action: {
                        UIApplication.shared.open(URL(string: Constants.SPL_INK_REPO_URL)!)
                    }) {
                        HStack {
                            Text("Data Source").foregroundColor(.primary)
                            Spacer()
                            Text("splatoon2.ink").foregroundColor(.secondary)
                            Image(systemName: "map.fill").foregroundColor(.secondary)
                        }
                        
                    }
                }
                
                Section(header: Text("About"),
                        footer: Text(Constants.VERSION_INFO)
                            .font(.caption))
                {
                    Button( action: { UIApplication.shared.open(URL(string: Constants.AUTHOR_GITHUB_URL)!) } ) {
                        HStack {
                            Text("Github").foregroundColor(.primary)
                            Spacer()
                            Text("@\(Constants.AUTHOR_GITHUB_HANDLE)").foregroundColor(.secondary)
                        }
                    }
                    
                    Button( action: { UIApplication.shared.open(URL(string: Constants.AUTHOR_TWITTER_URL)!) } ) {
                        HStack {
                            Text("Twitter").foregroundColor(.primary)
                            Spacer()
                            Text("@\(Constants.AUTHOR_TWITTER_HANDLE)").foregroundColor(.secondary)
                            
                        }
                    }
                    
                    Button( action: { UIApplication.shared.open(URL(string: Constants.AUTHOR_EMAIL_URL)!) } ) {
                        HStack {
                            Text("Feedback via Email").foregroundColor(.primary)
                            Spacer()
                            Image(systemName: "exclamationmark.bubble.fill").foregroundColor(.secondary)
                        }
                    }
                    
                }
                
            }
            .listStyle(GroupedListStyle())
            .navigationBarTitle(Text("Settings"))
            .navigationBarItems(
                
                // MARK: NavBar XMark Button
                trailing:
                Button(action:{
                    self.presentationMode.wrappedValue.dismiss()
                }) {
                    HStack {
                        Image(systemName: "xmark.circle.fill")
                            .foregroundColor(.primary)
                            .font(.system(size: Constants.NAVBAR_XMARK_SIZE, weight: .medium))
                            .shadow(radius: 5)
                        //                        .border(Color.red)
                    }
                    
                    .frame(width: Constants.TAPPABLE_AREA_MIN_SIDE, height: Constants.TAPPABLE_AREA_MIN_SIDE)
                    .background(
                        Color(UIColor.systemGray4)
                            .opacity(self.colorScheme == .dark ? 0.3 : 0.2)
                            .cornerRadius(5)
                    )
                    //                    .border(Color.red)
                }
                
                
            )
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
    
    func saveDefaultMode() {
        UserDefaults.standard.set(self.settingsDefaultMode, forKey: Constants.USERDEFAULTS_KEY_DEFAULTMODE)
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
            .environmentObject(Env(isForTest: true))
            .environment(\.colorScheme, .dark)
    }
}
