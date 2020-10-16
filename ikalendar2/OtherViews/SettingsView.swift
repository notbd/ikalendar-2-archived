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
    @Environment(\.openURL) var openURL
    
    @EnvironmentObject var env: Env
    
    @AppStorage(Constants.USERDEFAULTS_KEY_DEFAULTMODE_INT) var defaultLaunchMode: Int = 0
    
    var body: some View {
        NavigationView {
            List {
                
                Section(
                    header:
                    SettingsHeaderSizedText {
                        Text("Mode displayed when app launches:")
                    }
                        .padding(.top)
                    )
                {
                    // MARK: Default Mode Picker
                    Picker("Default Mode: ", selection: $defaultLaunchMode) {
                        ForEach(0 ..< Constants.MODE_SHORT_NAME.count) { index in
                            Text(Constants.MODE_SHORT_NAME[index])
                                .tag(index)
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                    .onChange(of: defaultLaunchMode) { newValue in
                        simpleHapticLight()
                    }
                }
                
                Section {
                    NavigationLink(
                        destination:
                        OtherOptionsView()
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
                    SettingsTinySizedText {
                        Text(Constants.COPYRIGHT_INFO)
                    }
                    )
                {
                    Button(action: {
                        simpleHapticLight()
                        
                        if let url = URL(string: Constants.SPLATOON_WEBSITE_URL) {
                            openURL(url)
                        } else {
                            simpleHapticError()
                        }
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
                        simpleHapticLight()
                        
                        if let url = URL(string: Constants.SPL_INK_REPO_URL) {
                            openURL(url)
                        } else {
                            simpleHapticError()
                        }
                    }) {
                        SettingsBodySizedText {
                            HStack {
                                Text("Data Source").foregroundColor(.primary)
                                Spacer()
                                Text("splatoon2.ink").foregroundColor(.secondary)
                                Image(systemName: "scroll.fill").foregroundColor(.secondary)
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
                        simpleHapticLight()

                        if let url = URL(string: Constants.AUTHOR_GITHUB_URL) {
                            openURL(url)
                        } else {
                            simpleHapticError()
                        }
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
                        simpleHapticLight()
                        
                        if let url = URL(string: Constants.AUTHOR_TWITTER_URL) {
                            openURL(url)
                        } else {
                            simpleHapticError()
                        }
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
                        simpleHapticLight()
                        
                        if let url = URL(string: Constants.AUTHOR_EMAIL_URL) {
                            openURL(url)
                        } else {
                            simpleHapticError()
                        }
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
            .listSeparatorStyle(.none)
            .listStyle(InsetGroupedListStyle())
            .navigationBarTitle(Text("Settings"))
            .navigationBarItems(
                
                // MARK: NavBar XMark Button
                trailing:
                Button(action:{
                    simpleHapticSuccess()
                    self.presentationMode.wrappedValue.dismiss()
                }) {
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
                    Text("Done")
                }
            )
        }
        .accentColor(.secondary)
        .navigationViewStyle(StackNavigationViewStyle())
    }
}

//struct StatefulPreviewWrapper<Value, Content: View>: View {
//    @State var value: Value
//    var content: (Binding<Value>) -> Content
//
//    var body: some View {
//        content($value)
//    }
//
//    init(_ value: Value, content: @escaping (Binding<Value>) -> Content) {
//        self._value = State(wrappedValue: value)
//        self.content = content
//    }
//}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
            .environmentObject(Env(isForTest: true))
            .environment(\.colorScheme, .dark)
//            .environment(\.sizeCategory, .extraSmall)
    }
}
