//
//  RotationCatalog.swift
//  ikalendar2
//
//  Created by Tianwei Zhang on 6/10/20.
//  Copyright © 2020 Tianwei Zhang. All rights reserved.
//

import Foundation


let testT = [   Rotation(id: 0, rule: "Turf War",        rule_filn: "turf_war",      stage_1_name: "Shifty Station",       stage_2_name: "Humpback Pump Track"),
                Rotation(id: 1, rule: "Turf War",        rule_filn: "turf_war",      stage_1_name: "Skipper Pavilion",    stage_2_name: "New Albacore Hotel")   ]
let testR = [   Rotation(id: 2, rule: "Tower Control",   rule_filn: "tower_control", stage_1_name: "MakoMart",       stage_2_name: "Inkblot Art Academy"),
                Rotation(id: 3, rule: "Rainmaker",       rule_filn: "rainmaker",     stage_1_name: "Manta Maria",    stage_2_name: "Goby Arena"),
                Rotation(id: 4, rule: "Splat Zones",     rule_filn: "splat_zones",   stage_1_name: "Kelp Dome",       stage_2_name: "Ancho-V Games"),
                Rotation(id: 5, rule: "Clam Blitz",      rule_filn: "clam_blitz",    stage_1_name: "Moray Towers",    stage_2_name: "The Reef")                 ]
let testL = [   Rotation(id: 4, rule: "Splat Zones",     rule_filn: "splat_zones",   stage_1_name: "Kelp Dome",       stage_2_name: "Ancho-V Games"),
                Rotation(id: 5, rule: "Clam Blitz",      rule_filn: "clam_blitz",    stage_1_name: "Moray Towers",    stage_2_name: "The Reef")                 ]

struct RotationCatalog: Decodable {
    
    var ranked: [Rotation]?
    var league: [Rotation]?
    var regular: [Rotation]?
    
    enum CodingKeys: String, CodingKey {
        case gachi
        case league
        case regular
    }
    
    // default initializer
    init() {
        
    }
    
    // for testing
    init(isForTest: Bool) {
        self.regular    = testT
        self.ranked     = testR
        self.league     = testL
    }
    
    init (from decoder: Decoder) throws {
        
        // Main container
        let container   = try decoder.container(keyedBy: CodingKeys.self)
        
        self.ranked     = try container.decode([Rotation].self, forKey: .gachi)
        self.league     = try container.decode([Rotation].self, forKey: .league)
        self.regular    = try container.decode([Rotation].self, forKey: .regular)
        
    }
    
}
