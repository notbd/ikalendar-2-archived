//
//  AppDelegate.swift
//  ikalendar2
//
//  Created by Tianwei Zhang on 5/9/20.
//  Copyright © 2020 Tianwei Zhang. All rights reserved.
//

import SwiftUI
import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        // MARK: - Register UserDefaults
        
        UserDefaults.standard.register(defaults: [Constants.USERDEFAULTS_KEY_DEFAULTMODE_INT:   1])
        UserDefaults.standard.register(defaults: [Constants.USERDEFAULTS_KEY_AUTOREFRESH_BOOL: true])
        
        UserDefaults.standard.register(defaults: [Constants.USERDEFAULTS_KEY_ISFIRSTLAUNCH_BOOL: true])
        UserDefaults.standard.register(defaults: [Constants.USERDEFAULTS_KEY_LASTVERSION_STRING: "2.1.0"])
        
        
        // MARK: - Set NavBar Font to SF Pro Rounded
        
        let largeTitleFontSize: CGFloat = 31
        let titleTextFontSize: CGFloat = 17

        // Here we get San Francisco with the desired weight
        let systemLargeTitleFont    = UIFont.systemFont(ofSize: largeTitleFontSize, weight: .bold)
        let systemTitleTextFont     = UIFont.systemFont(ofSize: titleTextFontSize,  weight: .semibold)

        // Will be SF Pro in case of failure.
        let largeTitleFont, titleTextFont: UIFont

        if let descriptor = systemLargeTitleFont.fontDescriptor.withDesign(.rounded) {
            largeTitleFont = UIFont(descriptor: descriptor, size: largeTitleFontSize)
        } else {
            largeTitleFont = systemLargeTitleFont
        }

        if let descriptor = systemTitleTextFont.fontDescriptor.withDesign(.rounded) {
            titleTextFont = UIFont(descriptor: descriptor, size: titleTextFontSize)
        } else {
            titleTextFont = systemTitleTextFont
        }

        UINavigationBar.appearance().largeTitleTextAttributes   = [.font : largeTitleFont]
        UINavigationBar.appearance().titleTextAttributes        = [.font : titleTextFont]
        
        
//        // MARK: - Config List Line Separator to none
//
//        UITableView.appearance().separatorStyle = .none
//        //        UITableView.appearance().backgroundColor = .clear
//        //        UITableViewCell.appearance().backgroundColor = .clear
        
        // MARK: - Config Segment Picker Text Style
        
        let pickerFontSize: CGFloat = 13
        
        let systemPickerSelectedFont    = UIFont.systemFont(ofSize: 14, weight: .semibold)
        let systemPickerNormalFont      = UIFont.systemFont(ofSize: 14, weight: .regular)
        
        let pickerSelectedFont, pickerNormalFont: UIFont
        
        if let descriptor = systemPickerSelectedFont.fontDescriptor.withDesign(.rounded) {
            pickerSelectedFont = UIFont(descriptor: descriptor, size: pickerFontSize)
        } else {
            pickerSelectedFont = systemPickerSelectedFont
        }
        
        if let descriptor = systemPickerNormalFont.fontDescriptor.withDesign(.rounded) {
            pickerNormalFont = UIFont(descriptor: descriptor, size: pickerFontSize)
        } else {
            pickerNormalFont = systemPickerNormalFont
        }
        
        UISegmentedControl.appearance().setTitleTextAttributes([NSAttributedString.Key.font: pickerSelectedFont],   for: .selected)
        UISegmentedControl.appearance().setTitleTextAttributes([NSAttributedString.Key.font: pickerNormalFont],     for: .normal)
        
        // MARK: - Configu List Header Background Color
        UITableViewHeaderFooterView.appearance().tintColor = UIColor.systemGray4.withAlphaComponent(0.5)
        
        return true
    }
    
    // MARK: UISceneSession Lifecycle
    
    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }
    
    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }
    
    
}

