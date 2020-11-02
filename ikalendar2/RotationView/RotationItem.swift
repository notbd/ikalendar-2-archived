//
//  RotationItem.swift
//  ikalendar2
//
//  Created by Tianwei Zhang on 5/10/20.
//  Copyright © 2020 Tianwei Zhang. All rights reserved.
//

import SwiftUI

struct RotationItem: View {
    
    @EnvironmentObject private var env: Env
    
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
    var maxRuleImgWidth_compact: CGFloat        { 32 }
    
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
    var FirstRuleTitleFontSize_compact: CGFloat      { 16 }
    var FirstRemainingTimeStringFontSize: CGFloat             { 14 }
    var FirstRemainingTimeStringFontSize_compact: CGFloat     { 13 }
    
    // Spacings
    var FirstRuleSectionSpacing: CGFloat             { 14 }
    var FirstTimeSectionSpacing: CGFloat             { 14 }
    var FirstStageSectionSpacing: CGFloat            { 8 }
    
    var FirstRuleImgWidth: CGFloat                   { 32 }
    
    var FirstExtraHeaderYOffset: CGFloat             { 3 }
    
    @State var remainTimeString: String = ""
//    private let remainTimer = Timer.publish(every: 1, tolerance: 0.2, on: .main, in: .common).autoconnect()
    
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
            
            // Current rotation
            if index == 0 {
                VStack {
                    
                    // Header Section
                    HStack (alignment: .center, spacing: FirstRuleSectionSpacing) {
                        
                        // Rule Img & Title
                        Image(rotation.rule_filn)
                            .resizable()
                            .antialiased(true)
                            .scaledToFit()
                            .shadow(radius: 5)
                            .frame(width: FirstRuleImgWidth)

                        Text(rotation.rule)
                            .font(.custom("Splatoon2", size: isViewOverCompact ? FirstRuleTitleFontSize_compact : FirstRuleTitleFontSize))
                        
                        Spacer()
                        
                        Text(remainTimeString)
                            .font(.custom("Splatoon2", size: isViewOverCompact ? FirstRemainingTimeStringFontSize_compact : FirstRemainingTimeStringFontSize))
                            .foregroundColor(.secondary)
                            .onReceive(env.refreshTimer) { _ in
                                updateTimeString()
                            }
                            .onAppear {
                                updateTimeString()
                            }
                        
                    }
                    
                    Spacer()
                    
                    // Stage Section
                    HStack(alignment: .center, spacing: FirstStageSectionSpacing) {
                        FirstStageCell(imgFiln: rotation.stage_1_filn, stageName: rotation.stage_1_name, StageNameFontSize: StageNameFontSize)
                        
                        Spacer()
                        
                        FirstStageCell(imgFiln: rotation.stage_2_filn, stageName: rotation.stage_2_name, StageNameFontSize: StageNameFontSize)
                    }
                }
                .padding(.top, 8)
                .padding(.bottom)
            }
            else
            
            // Later rotations
            {
                HStack {
                    Spacer()
                    
                    VStack {
                        Image(rotation.rule_filn)
                            .resizable()
                            .antialiased(true)
                            .scaledToFit()
                            .shadow(radius: 5)
                            .frame(maxWidth: isViewOverCompact ? maxRuleImgWidth_compact : maxRuleImgWidth)
                            .offset(y: isViewOverCompact ? RuleImgOffset_compact : RuleImgOffset)
                        Text(isViewOverCompact ? getShortRuleName(for: rotation.rule) : rotation.rule)
                            .font(.custom("Splatoon2", size: isViewOverCompact ? RuleTitleFontSize_compact : RuleTitleFontSize))
                    }
                    .offset(x: RuleSectionOffset_compact)
                    
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
    
    func updateTimeString() {
        guard let currRotationEndTime = self.env.currRotationEndTime else { return }
        let currTime = Date()
        self.remainTimeString = (currRotationEndTime - currTime).toRotationRemainingTimeString() + " remaining"
    }
    
    func getShortRuleName(for ruleName: String) -> String {
        switch ruleName {
            
        case "Splat Zones":
            return "Zones"
            
        case "Tower Control":
            return "Tower"
            
        case "Rainmaker":
            return "Rain"
            
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
            
            StageNameLabelSmall(stageName: stageName, StageNameFontSize: StageNameFontSize)
                .offset(x: -3, y: -3)
        }
    }
}

struct StageNameLabelSmall: View {
    
    var stageName: String
    var StageNameFontSize: CGFloat
    
    var body: some View {
        ZStack {
            Rectangle()
                .cornerRadius(4)
                .foregroundColor(.black)
                .opacity(0.7)
            
            Text(self.stageName)
                .shadow(radius: 10)
                .font(.custom("Splatoon2", size: self.StageNameFontSize))
                .foregroundColor(.white)
                .padding(.leading, 6)
                .padding(.trailing, 6)
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
            if isViewOverCompact {
                VStack(alignment: .trailing) {
                    Spacer()
                    
                    Image(imgFiln)
                        .resizable()
                        .scaledToFit()
                        .cornerRadius(4)
                        .shadow(radius: 5)
                        .offset(y: StageImgOffset)
                    Text(stageName)
                        .font(.custom("Splatoon2", size: StageNameFontSize - 1))
                    
                    Spacer()
                }
                .frame(minWidth: minCellWidth)
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
                .frame(maxWidth: maxCellWidth)
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
