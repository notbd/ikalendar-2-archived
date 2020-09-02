//
//  SettingsView.swift
//  ikalendar2
//
//  Created by Tianwei Zhang on 5/9/20.
//  Copyright © 2020 Tianwei Zhang. All rights reserved.
//

import SwiftUI

struct SettingsView: View {
    
    @EnvironmentObject var env: Env
    
    @State private var settingsDefaultMode = UserDefaults.standard.integer(forKey: Constants.USERDEFAULTS_KEY_DEFAULTMODE)
    
    var body: some View {
        NavigationView {
            Form {
                
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
            .navigationBarTitle(Text("Settings"))
            .navigationBarItems(
                trailing:
                Button(action:{
                    self.env.isSettingsPresented.toggle()
                }) {
                    Image(systemName: "xmark.circle.fill")
                        .foregroundColor(.primary)
                        .font(.system(size: 18, weight: .medium))
                        .shadow(radius: 5)
                        .frame(width: 25)
                }
                
            )
        }
        .navigationViewStyle(StackNavigationViewStyle())
        //        .onAppear {
        //            UITableViewCell.appearance().backgroundColor = .systemGray
        //        }
        //        .onDisappear {
        //            UITableViewCell.appearance().backgroundColor = .clear
        //        }
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
