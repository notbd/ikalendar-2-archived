//
//  RotationModel.swift
//  ikalendar2
//
//  Created by Tianwei Zhang on 5/10/20.
//  Copyright © 2020 Tianwei Zhang. All rights reserved.
//

import SwiftUI

struct Rotation: Hashable, Codable, Identifiable {
    var id: Int
    var rule: Rule
    var rule_filn: Rule_filn
    var time: String
    var map_1_name: String
    var map_1_filn: String
    var map_2_name: String
    var map_2_filn: String
    
    enum Rule: String, CaseIterable, Codable, Hashable {
        case SZ = "ガチエリア"
        case TC = "ガチヤグラ"
        case RM = "ガチホコバトル"
        case CB = "ガチアサリ"
    }
    
    enum Rule_filn: String, CaseIterable, Codable, Hashable {
        case SZ = "SZ_small"
        case TC = "TC_small"
        case RM = "RM_small"
        case CB = "CB_small"
    }
}
