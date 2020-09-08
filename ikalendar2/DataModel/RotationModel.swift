//
//  RotationModel.swift
//  ikalendar2
//
//  Created by Tianwei Zhang on 5/10/20.
//  Copyright © 2020 Tianwei Zhang. All rights reserved.
//

import SwiftUI

struct Rotation: Identifiable, Hashable {
    
    var id: Int
    var rule: String
    var rule_filn: String
    var time: String
    var start_time: Double
    var end_time: Double
    var stage_1_name: String
    var stage_1_filn: String
    var stage_2_name: String
    var stage_2_filn: String
    
    // Placeholder initializer while data not loaded yet
    init (id: Int,
          rule: String,
          rule_filn: String,
          stage_1_name: String,
          stage_2_name: String) {
        self.id = id
        self.rule = rule
        self.rule_filn = rule_filn
        self.start_time = 0.0
        self.end_time = 0.0
        self.time = "18:00 - 20:00"
        self.stage_1_name = stage_1_name
        self.stage_1_filn = stage_1_name
        self.stage_2_name = stage_2_name
        self.stage_2_filn = stage_2_name
    }
    
    // init for empty placeholder rotation
    init (isEmpty: Bool) {
        self.id = -3
        self.rule = ""
        self.rule_filn = ""
        self.start_time = 0.0
        self.end_time = 0.0
        self.time = ""
        self.stage_1_name = ""
        self.stage_1_filn = ""
        self.stage_2_name = ""
        self.stage_2_filn = ""
    }
}

extension Rotation: Decodable {
    
    enum CodingKeys: String, CodingKey {
        
        case gachi
        case league
        case regular
        
        case id
        
        case start_time
        case end_time
        
        case rule
        
        case stage_a
        case stage_b
        
        case name
        case key
    }

    init (from decoder: Decoder) throws {
        
        // Main container
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        // Parse id
        self.id = try container.decode(Int.self, forKey: .id)
        
        // Parse start time
        self.start_time = try container.decode(Double.self, forKey: .start_time)
        
        // Parse end time
        self.end_time = try container.decode(Double.self, forKey: .end_time)
        
        // Compose time string
        let dateFormatter = DateFormatter()
        dateFormatter.locale = NSLocale.current
        dateFormatter.dateFormat = "h:mm a"
        
        let Date_start_time = Date(timeIntervalSince1970: start_time)
        let Date_end_time = Date(timeIntervalSince1970: end_time)
        let str_start_time = dateFormatter.string(from: Date_start_time)
        let str_end_time = dateFormatter.string(from: Date_end_time)
        
        // set time string
        self.time = "\(str_start_time) - \(str_end_time)"
        
        // Rule container
        let ruleContainer = try container.nestedContainer(keyedBy: CodingKeys.self, forKey: .rule)
        
        // Parse rule name
        self.rule = try ruleContainer.decode(String.self, forKey: .name)
        
        // Parse rule key
        self.rule_filn = try ruleContainer.decode(String.self, forKey: .key)
        
        // Stage containers
        let stage1Container = try container.nestedContainer(keyedBy: CodingKeys.self, forKey: .stage_a)
        let stage2Container = try container.nestedContainer(keyedBy: CodingKeys.self, forKey: .stage_b)
        
        // Parse stage names
        self.stage_1_name = try stage1Container.decode(String.self, forKey: .name)
        self.stage_2_name = try stage2Container.decode(String.self, forKey: .name)
        
        // Process stage filn
        self.stage_1_filn = self.stage_1_name
        self.stage_2_filn = self.stage_2_name
    }
    
}
