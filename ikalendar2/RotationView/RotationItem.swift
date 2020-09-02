//
//  RotationItem.swift
//  ikalendar2
//
//  Created by Tianwei Zhang on 5/10/20.
//  Copyright © 2020 Tianwei Zhang. All rights reserved.
//

import SwiftUI

struct RotationItem: View {
    
    var rotation: Rotation
    var index: Int
    var width: CGFloat
    
    // Determine if View Width tighter than iPhone 8 Width
    var shortModeNameThreshold: CGFloat         { 375 }
    var isViewOverCompact: Bool                 { width < shortModeNameThreshold }
    
    // Font Sizes
    var ExtraHeaderFontSize: CGFloat            { 15 }
    var TimeStringFontSize: CGFloat             { 12 }
    var RuleTitleFontSize: CGFloat              { 14 }
    var RuleTitleFontSize_compact: CGFloat      { 13 }
    var StageNameFontSize: CGFloat              { 10 }
    
    // min/max Widths
    var maxRuleImgWidth: CGFloat                { 38 }
    var maxRuleImgWidth_compact: CGFloat        { 34 }
    
    var maxStageSectionWidth: CGFloat           { width * 0.6 }
    
    // Offsets
    var RuleSectionOffset: CGFloat              { -8 }
    var RuleSectionOffset_compact: CGFloat      { -8 }
    
    var RuleImgOffset: CGFloat                  { 6 }
    var RuleImgOffset_compact: CGFloat          { 10 }
    
    var StageImgOffset: CGFloat                 { 6 }
    
    // StageCell Parameters
    var minStageCellWidth: CGFloat              { 95 }
    var maxStageCellWidth: CGFloat              { 120 }
    
    
    
    var body: some View {
        
        Section(header:
            // Header
            VStack(alignment: .leading) {
                if index < Constants.EXTRA_HEADERS.count {
                    Text(Constants.EXTRA_HEADERS[index])
                        .font(.custom("Splatoon2", size: ExtraHeaderFontSize))
                        .foregroundColor(.primary)
                }
                
                Text(rotation.time)
                    .font(.custom("Splatoon2", size: TimeStringFontSize))
                    .foregroundColor(.secondary)
            }
        ) {
            
            // Content
            HStack {
                Spacer()
                
                // Rule Section: when normal width
                if !isViewOverCompact {
                    VStack {
                        Image(rotation.rule_filn)
                            .resizable()
                            .antialiased(true)
                            .scaledToFit()
                            .shadow(radius: 5)
                            .frame(maxWidth: maxRuleImgWidth)
                            .offset(y: RuleImgOffset)
                        Text(rotation.rule)
                            .font(.custom("Splatoon2", size: RuleTitleFontSize))
                        
                    }
                    .offset(x: RuleSectionOffset)
                }
                    
                // Rule Section: when width too small
                else {
                    VStack {
                        Image(rotation.rule_filn)
                            .resizable()
                            .antialiased(true)
                            .scaledToFit()
                            .shadow(radius: 5)
                            .frame(maxWidth: maxRuleImgWidth_compact)
                            .offset(y: RuleImgOffset_compact)
                        Text(getShortRuleName(for: rotation.rule))
                            .font(.custom("Splatoon2", size: RuleTitleFontSize_compact))
                    }
                    .offset(x: RuleSectionOffset_compact)
                }
                
                Spacer()
                
                // Stage Section
                HStack {
                    StageCell(imgFiln: rotation.stage_1_filn, stageName: rotation.stage_1_name, StageImgOffset: StageImgOffset, StageNameFontSize: StageNameFontSize, minCellWidth: minStageCellWidth, maxCellWidth: maxStageCellWidth, isViewOverCompact: isViewOverCompact)
                    
                    Spacer()
                    
                    StageCell(imgFiln: rotation.stage_2_filn, stageName: rotation.stage_2_name, StageImgOffset: StageImgOffset, StageNameFontSize: StageNameFontSize, minCellWidth: minStageCellWidth, maxCellWidth: maxStageCellWidth, isViewOverCompact: isViewOverCompact)
                }
                .frame(maxWidth: maxStageSectionWidth)
            }
        }
    }
    
    func getShortRuleName(for ruleName: String) -> String {
        switch ruleName {
            
        case "Splat Zones":
            return "Zones"
            
        case "Tower Control":
            return "Tower"
            
        case "Rainmaker":
            return "Rainmaker"
            
        case "Clam Blitz":
            return "Clams"
            
        case "Turf War":
            return "Turf"
            
        default:
            return "N/A"
        }
    }
}

struct StageCell: View {
    
    var imgFiln: String
    var stageName: String
    
    var StageImgOffset: CGFloat
    var StageNameFontSize: CGFloat
    
    var minCellWidth: CGFloat
    var maxCellWidth: CGFloat
    
    var isViewOverCompact: Bool
    
    var body: some View {
        Group {
            
            // Compact StageCell
            if !isViewOverCompact {
                VStack(alignment: .trailing) {
                    Spacer()
                    
                    Image(imgFiln)
                        .resizable()
                        .scaledToFit()
                        .cornerRadius(4)
                        .shadow(radius: 5)
                        .offset(y: StageImgOffset)
                    Text(stageName)
                        .font(.custom("Splatoon2", size: StageNameFontSize))
                    
                    Spacer()
                }
                .frame(maxWidth: maxCellWidth)
            }
            
            // Normal StageCell
            else {
                VStack(alignment: .trailing) {
                    Spacer()
                    
                    Image(imgFiln)
                        .resizable()
                        .scaledToFit()
                        .cornerRadius(4)
                        .shadow(radius: 5)
                        .offset(y: StageImgOffset)
                    Text(stageName)
                        .font(.custom("Splatoon2", size: StageNameFontSize))
                    
                    Spacer()
                }
                .frame(minWidth: minCellWidth)
            }
        }
    }
}

struct RotationItem_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            RotationView()
                .environmentObject(Data(isForTest: true))
                .preferredColorScheme(.light)
                .previewDevice(PreviewDevice(rawValue: "iPhone SE"))
            
            RotationView()
                .environmentObject(Data(isForTest: true))
                .preferredColorScheme(.light)
                .previewDevice(PreviewDevice(rawValue: "iPhone 8"))
            RotationView()
                .environmentObject(Data(isForTest: true))
                .preferredColorScheme(.light)
                .previewDevice(PreviewDevice(rawValue: "iPhone 11 Pro Max"))
        }
        
    }
}
