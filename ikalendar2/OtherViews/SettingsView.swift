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
    
//    @State private var settingsDefaultMode = UserDefaults.standard.integer(forKey: Constants.USERDEFAULTS_KEY_DEFAULTMODE_INT)
    
    var body: some View {
        NavigationView {
            Form {
                
                Section(
                    header:
                    SettingsHeaderSizedText {
                        Text("Mode displayed when app launches:")
                    }
                        .padding(.top)
                    )
                {
                    Picker("Default Mode: ", selection: self.$env.defaultLaunchMode) {
                        ForEach(0 ..< Constants.MODE_SHORT_NAME.count) { index in
                            Text(Constants.MODE_SHORT_NAME[index])
                                .tag(index)
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
//                    .onReceive([self.settingsDefaultMode].publisher.first()) { value in
//                        self.saveDefaultMode()
//                    }
                }
                
                Section() {
                    NavigationLink(destination:
                    OtherOptionsView()
//                        .environmentObject(self.env)
                    ) {
                        SettingsBodySizedText {
                            Text("Other Options")
                        }
                    }
                }
                
                Section(
                    header:
                    SettingsHeaderSizedText {
                        Text("Acknowledgement")
                    }
                    ,footer:
                    SettingsFooterSizedText {
                        Text(Constants.COPYRIGHT_INFO)
                    }
                    )
                {
                    Button(action: {
                        UIApplication.shared.open(URL(string: Constants.SPLATOON_WEBSITE_URL)!)
                    }) {
                        SettingsBodySizedText {
                            HStack {
                                Text("Splatoon™ 2").foregroundColor(.primary)
                                Spacer()
                                Text("Official Website").foregroundColor(.secondary)
                                Image(systemName: "globe").foregroundColor(.secondary)
                            }
                        }
                    }
                    
                    Button(action: {
                        UIApplication.shared.open(URL(string: Constants.SPL_INK_REPO_URL)!)
                    }) {
                        SettingsBodySizedText {
                            HStack {
                                Text("Data Source").foregroundColor(.primary)
                                Spacer()
                                Text("splatoon2.ink").foregroundColor(.secondary)
                                Image(systemName: "map.fill").foregroundColor(.secondary)
                            }
                        }
                    }
                }
                
                Section(
                    header:
                    SettingsHeaderSizedText {
                        Text("About")
                    }
                    ,footer:
                    SettingsFooterSizedText {
                        Text(Constants.VERSION_INFO)
                    }
                    )
                {
                    Button(action: {
                        UIApplication.shared.open(URL(string: Constants.AUTHOR_GITHUB_URL)!)
                    }) {
                        SettingsBodySizedText {
                            HStack {
                                Text("Github").foregroundColor(.primary)
                                Spacer()
                                Text("@\(Constants.AUTHOR_GITHUB_HANDLE)").foregroundColor(.secondary)
                            }
                        }
                    }
                    
                    Button(action: {
                        UIApplication.shared.open(URL(string: Constants.AUTHOR_TWITTER_URL)!)
                    }) {
                        SettingsBodySizedText {
                            HStack {
                                Text("Twitter").foregroundColor(.primary)
                                Spacer()
                                Text("@\(Constants.AUTHOR_TWITTER_HANDLE)").foregroundColor(.secondary)
                            }
                        }
                    }
                    
                    Button(action: {
                        UIApplication.shared.open(URL(string: Constants.AUTHOR_EMAIL_URL)!)
                    }) {
                        SettingsBodySizedText {
                            HStack {
                                Text("Feedback via Email").foregroundColor(.primary)
                                Spacer()
                                Image(systemName: "exclamationmark.bubble.fill").foregroundColor(.secondary)
                            }
                        }
                    }
                }
            }
//            .listStyle(GroupedListStyle())
            .navigationBarTitle(Text("Settings"))
//            .navigationBarItems(
//                
//                // MARK: NavBar XMark Button
//                trailing:
//                Button(action:{
//                    self.presentationMode.wrappedValue.dismiss()
////                    self.env.isSettingsPresented.toggle()
//                }) {
//                    HStack {
//                        Image(systemName: "xmark.circle.fill")
//                            .foregroundColor(.primary)
//                            .font(.system(size: Constants.NAVBAR_XMARK_SIZE, weight: .medium))
//                            .shadow(radius: 5)
//                    }
//                    
//                    .frame(width: Constants.TAPPABLE_AREA_MIN_SIDE, height: Constants.TAPPABLE_AREA_MIN_SIDE)
//                    .background(
//                        Color(UIColor.systemGray4)
//                            .opacity(self.colorScheme == .dark ? 0.3 : 0.2)
//                            .cornerRadius(5)
//                    )
//                }
//            )
        }
        .accentColor(.secondary)
        .navigationViewStyle(StackNavigationViewStyle())
    }
    
//    func saveDefaultMode() {
//        UserDefaults.standard.set(self.settingsDefaultMode, forKey: Constants.USERDEFAULTS_KEY_DEFAULTMODE_INT)
//    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
            .environmentObject(Env(isForTest: true))
            .environment(\.colorScheme, .dark)
//            .environment(\.sizeCategory, .extraSmall)
    }
}
