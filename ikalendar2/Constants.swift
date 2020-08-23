//
//  Constants.swift
//  ikalendar2
//
//  Created by Tianwei Zhang on 6/9/20.
//  Copyright © 2020 Tianwei Zhang. All rights reserved.
//

import Foundation

struct Constants {
    
    static let appVersion = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String
    
    static var ROTATIONS_URL = "https://splatoon2.ink/data/schedules.json"
    static var SR_SCHEDULES_URL = "https://splatoon2.ink/data/coop-schedules.json"

    static let USERDEFAULTS_KEY_DEFAULTMODE = "defaultMode"
    
    static let AUTHOR_TWITTER_URL = "https://twitter.com/gppppa_"
    static let AUTHOR_GITHUB_URL = "https://github.com/zhang13music"
    static let AUTHOR_EMAIL_URL = "mailto:zhang13music@outlook.com"
    
    static let SPL_INK_URL = "https://github.com/misenhower/splatoon2.ink"
     
    static let COPYRIGHT_INFO =
    """
    ikalendar2 is neither commercial nor affiliated with Nintendo. All product names, logos, and brands are property of their respective owners.

    """
    
    static let VERSION_INFO =
    """
    ikalendar2  v\(appVersion ?? "?")
    © 2020 Tianwei Peter Zhang
    """
    
}
