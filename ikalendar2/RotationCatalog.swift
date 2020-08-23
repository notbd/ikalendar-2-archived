//
//  RotationCatalog.swift
//  ikalendar2
//
//  Created by Tianwei Zhang on 6/10/20.
//  Copyright © 2020 Tianwei Zhang. All rights reserved.
//

import Foundation

let placeholderRotation = Rotation(loadingMsg: "Loading...")
let hintRotation        = Rotation(loadingMsg: "(Press mode icon to manually refresh)")

struct RotationCatalog: Decodable {
    
    var ranked: [Rotation]
    var league: [Rotation]
    var regular: [Rotation]
    
    enum CodingKeys: String, CodingKey {
        
        case gachi
        case league
        case regular
        
    }
    
    init() {
        self.ranked = [placeholderRotation, hintRotation]
        self.league = [placeholderRotation, hintRotation]
        self.regular = [placeholderRotation, hintRotation]
    }
    
    init (from decoder: Decoder) throws {
    
        // Main container
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.ranked = try container.decode([Rotation].self, forKey: .gachi)
        self.league = try container.decode([Rotation].self, forKey: .league)
        self.regular = try container.decode([Rotation].self, forKey: .regular)
    
    }
    
}
