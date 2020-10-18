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
    var parentWidth: CGFloat
    
    // Determine if View Width tighter than iPhone 8 Width
    var shortModeNameThreshold: CGFloat         { 375 }
    var isViewOverCompact: Bool                 { parentWidth < shortModeNameThreshold }
    
    // Font Sizes
    var ExtraHeaderFontSize: CGFloat            { 15 }
    var TimeStringFontSize: CGFloat             { 12 }
    var RuleTitleFontSize: CGFloat              { 14 }
    var RuleTitleFontSize_compact: CGFloat      { 13 }
    var StageNameFontSize: CGFloat              { 10 }
    
    // min/max Widths
    var maxRuleImgWidth: CGFloat                { 40 }
    var maxRuleImgWidth_compact: CGFloat        { 34 }
    
    var maxStageSectionWidth: CGFloat           { parentWidth * 0.6 }
    
    // Offsets
    var RuleSectionOffset: CGFloat              { -8 }
    var RuleSectionOffset_compact: CGFloat      { -8 }
    
    var RuleImgOffset: CGFloat                  { 8 }
    var RuleImgOffset_compact: CGFloat          { 10 }
    
    var StageImgOffset: CGFloat                 { 6 }
    
    // StageCell Parameters
    var minStageCellWidth: CGFloat              { 95 }
    var maxStageCellWidth: CGFloat              { 120 }
    
    // MARK: - First Cell Parameters
    
    var FirstRuleTitleFontSize: CGFloat              { 18 }
    var FirstRuleTitleFontSize_compact: CGFloat      { 13 }
    
    // Spacings
    var FirstRuleSectionSpacing: CGFloat             { 14 }
    var FirstTimeSectionSpacing: CGFloat             { 14 }
    var FirstStageSectionSpacing: CGFloat            { 8 }
    
    var FirstRuleImgWidth: CGFloat                   { 32 }
    
    var FirstExtraHeaderYOffset: CGFloat             { 3 }
    
    var body: some View {
        
        
        Section(header:
            // Header
            HStack() {
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
            if index == 0 {
                VStack {
                    
                    // Header Section
                    HStack (alignment: .center, spacing: FirstRuleSectionSpacing) {
                        
                        Spacer()
                        
                        // Rule Img & Title
                        Image(rotation.rule_filn)
                            .resizable()
                            .antialiased(true)
                            .scaledToFit()
                            .shadow(radius: 5)
                            .frame(width: FirstRuleImgWidth)

                        Text(rotation.rule)
                            .font(.custom("Splatoon2", size: FirstRuleTitleFontSize))
                        
                        Spacer()
                        
                    }
                    
                    Spacer()
                    
                    // Stage Section
                    HStack(alignment: .center, spacing: FirstStageSectionSpacing) {
                        FirstStageCell(imgFiln: rotation.stage_1_filn, stageName: rotation.stage_1_name, StageNameFontSize: StageNameFontSize
    //                        , minCellWidth: minStageCellWidth, maxCellWidth: maxStageCellWidth
                        )
                        
                        
    //                    Rectangle()
    //                    .foregroundColor(.clear)
    //                    .frame(width: 50)
                        
                        Spacer()
                        
                        FirstStageCell(imgFiln: rotation.stage_2_filn, stageName: rotation.stage_2_name, StageNameFontSize: StageNameFontSize
    //                        , minCellWidth: minStageCellWidth, maxCellWidth: maxStageCellWidth
                        )
                    }
                }
            }
            else
            {
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
                        Spacer()
                        
                        StageCell(imgFiln: self.rotation.stage_1_filn, stageName: self.rotation.stage_1_name, StageImgOffset: self.StageImgOffset, StageNameFontSize: self.StageNameFontSize, minCellWidth: self.minStageCellWidth, maxCellWidth: self.maxStageCellWidth, isViewOverCompact: self.isViewOverCompact)
                        
                        Spacer()
                        
                        StageCell(imgFiln: self.rotation.stage_2_filn, stageName: self.rotation.stage_2_name, StageImgOffset: self.StageImgOffset, StageNameFontSize: self.StageNameFontSize, minCellWidth: self.minStageCellWidth, maxCellWidth: self.maxStageCellWidth, isViewOverCompact: self.isViewOverCompact)
                        
                        Spacer()
                    }
                    .frame(maxWidth: self.maxStageSectionWidth)
    //                .rotation3DEffect(.degrees(7), axis: (x: 0, y: -1, z: 0))
                }
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

struct FirstStageCell: View {
    
    var imgFiln: String
    var stageName: String
    
    var StageNameFontSize: CGFloat
    
//    var minCellWidth: CGFloat
//    var maxCellWidth: CGFloat
    
    var body: some View {
        
        ZStack(alignment: .bottomTrailing) {
            Image(imgFiln)
                .resizable()
                .scaledToFit()
                .cornerRadius(4)
                .shadow(radius: 5)
            
            StageNameLabel(stageName: stageName, StageNameFontSize: StageNameFontSize)
                .offset(x: -4, y: -4)
            
        }
//        .frame(minWidth: minCellWidth, maxWidth: maxCellWidth)
        
    }
}

struct StageNameLabelSmall: View {
    
    var stageName: String
    var StageNameFontSize: CGFloat
    
    var body: some View {
        ZStack {
            Rectangle()
                .cornerRadius(6)
                .foregroundColor(.black)
                .opacity(0.75)
            
            Text(self.stageName)
                .shadow(radius: 10)
                .font(.custom("Splatoon2", size: self.StageNameFontSize))
                .foregroundColor(.white)
                .padding(.leading, 8)
                .padding(.trailing, 8)
        }
        .fixedSize()
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
                .environmentObject(Env(isForTest: true))
                .preferredColorScheme(.light)
                .previewDevice(PreviewDevice(rawValue: "iPhone SE"))
            
            RotationView()
                .environmentObject(Env(isForTest: true))
                .preferredColorScheme(.light)
                .previewDevice(PreviewDevice(rawValue: "iPhone 8"))
            RotationView()
                .environmentObject(Env(isForTest: true))
                .preferredColorScheme(.light)
                .previewDevice(PreviewDevice(rawValue: "iPhone 11 Pro Max"))
        }
        
    }
}
