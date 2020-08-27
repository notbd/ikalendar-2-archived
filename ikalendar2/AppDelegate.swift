//
//  AppDelegate.swift
//  ikalendar2
//
//  Created by Tianwei Zhang on 5/9/20.
//  Copyright © 2020 Tianwei Zhang. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {



    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        
        // MARK: Set NavBar Font to SF Pro Rounded
        
        let largeTitleFontSize: CGFloat = 34
        let titleTextFontSize: CGFloat = 17
    
        // Here we get San Francisco with the desired weight
        let systemLargeTitleFont    = UIFont.systemFont(ofSize: largeTitleFontSize, weight: .bold)
        let systemTitleTextFont     = UIFont.systemFont(ofSize: titleTextFontSize,  weight: .bold)

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
        
        // MARK: Config List Line Separator to none
        
        UITableView.appearance().separatorStyle = .none
        
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

