//
//  Constants.swift
//  ikalendar2
//
//  Created by Tianwei Zhang on 6/9/20.
//  Copyright © 2020 Tianwei Zhang. All rights reserved.
//

import Foundation

struct Constants {
    
//    MARK: UserDefaults Keys
    
    static let USERDEFAULTS_KEY_DEFAULTMODE = "defaultMode"
    
    
//    MARK: Data URLs
    
    static let ROTATIONS_URL    = "https://splatoon2.ink/data/schedules.json"
    static let SR_SCHEDULES_URL = "https://splatoon2.ink/data/coop-schedules.json"
    
//    MARK: Extra Headers
    
    static let EXTRA_HEADERS = ["NOW:", "NEXT:", "FUTURE:"]

//    MARK: Settings Page Strings
    
    static let appVersion   = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String
    static let appBuildNumber  = Bundle.main.infoDictionary?["CFBundleVersion"] as? String
    
    static let AUTHOR_GITHUB_HANDLE     = "zhang13music"
    static let AUTHOR_TWITTER_HANDLE    = "gppppa_"
    
    static let AUTHOR_GITHUB_URL    = "https://github.com/\(AUTHOR_GITHUB_HANDLE)"
    static let AUTHOR_TWITTER_URL   = "https://twitter.com/\(AUTHOR_TWITTER_HANDLE)"
    static let AUTHOR_EMAIL_URL     = "mailto:zhang13music@outlook.com"
    
    static let SPLATOON_WEBSITE_URL = "https://splatoon.nintendo.com/"
    static let SPL_INK_REPO_URL = "https://github.com/misenhower/splatoon2.ink"
     
    static let COPYRIGHT_INFO =
    """
    • Splatoon™ 2 is a trademark of Nintendo®.
    • ikalendar2 is an unofficial companion app for Splatoon 2, and is not affiliated or associated with Nintendo. All item names, logos and trademarks are property of their respective owners.

    """
    
    static let VERSION_INFO =
    """
    ikalendar2  v\(appVersion ?? "?")
    Copyright © 2020 Peter Zhang
    """
    
}
