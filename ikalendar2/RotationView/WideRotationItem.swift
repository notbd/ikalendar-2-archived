//
//  WideRotationItem.swift
//  ikalendar2
//
//  Created by Tianwei Zhang on 8/31/20.
//  Copyright © 2020 Tianwei Zhang. All rights reserved.
//

import SwiftUI

struct WideRotationItem: View {
    
    var rotation: Rotation
    var index: Int
    var width: CGFloat
    
    var ExtraHeaderFontSize: CGFloat            { 20 }
    var TimeStringFontSize: CGFloat             { 16 }
    var RuleTitleFontSize: CGFloat              { 16 }
    var StageNameFontSize: CGFloat              { 12 }
    
    var RuleImgWidth: CGFloat                   { 32 }
    
    var ExtraHeaderYOffset: CGFloat             { 3 }
    
    // Spacings
    var RuleSectionSpacing: CGFloat             { 14 }
    var TimeSectionSpacing: CGFloat             { 14 }
    var StageSectionSpacing: CGFloat            { width * 0.05 }
    
    // StageCell Parameters
//    var minStageCellWidth: CGFloat              { width / 2 - 100 }
//    var maxStageCellWidth: CGFloat              { width / 2 - 100 }
    
    var body: some View {
        
        Group {
            
            // Content
            VStack {
                
                // Header Section
                HStack (alignment: .bottom, spacing: RuleSectionSpacing) {
                    
                    // Rule Img & Title
                    Image(rotation.rule_filn)
                        .resizable()
                        .antialiased(true)
                        .scaledToFit()
                        .shadow(radius: 5)
                        .frame(width: RuleImgWidth)

                    Text(rotation.rule)
                        .font(.custom("Splatoon2", size: RuleTitleFontSize))
                    
                    Spacer()
                    
                    // Time String
                    HStack(alignment: .bottom, spacing: TimeSectionSpacing) {
                        
                        if index < Constants.EXTRA_HEADERS.count {
                            Text(Constants.EXTRA_HEADERS[index])
                                .font(.custom("Splatoon2", size: ExtraHeaderFontSize))
                                .foregroundColor(.secondary)
                                .offset(y: ExtraHeaderYOffset)
                        }
                        
                        Text(rotation.time)
                            .font(.custom("Splatoon2", size: TimeStringFontSize))
                            .foregroundColor(.primary)
                        
                    }
                }
                
                Spacer()
                
                // Stage Section
                HStack(alignment: .center, spacing: StageSectionSpacing) {
                    WideStageCell(imgFiln: rotation.stage_1_filn, stageName: rotation.stage_1_name, StageNameFontSize: StageNameFontSize
//                        , minCellWidth: minStageCellWidth, maxCellWidth: maxStageCellWidth
                    )
                    
                    
//                    Rectangle()
//                    .foregroundColor(.clear)
//                    .frame(width: 50)
                    
                    Spacer()
                    
                    WideStageCell(imgFiln: rotation.stage_2_filn, stageName: rotation.stage_2_name, StageNameFontSize: StageNameFontSize
//                        , minCellWidth: minStageCellWidth, maxCellWidth: maxStageCellWidth
                    )
                }
            }
            
            Divider()
        }
    }
}

struct WideStageCell: View {
    
    var imgFiln: String
    var stageName: String
    
    var StageNameFontSize: CGFloat
    
//    var minCellWidth: CGFloat
//    var maxCellWidth: CGFloat
    
    var body: some View {
        
        ZStack(alignment: .bottomTrailing) {
            Image(getLargeStageImageFiln(for: self.imgFiln))
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

func getLargeStageImageFiln(for imgFiln: String) -> String {
    return imgFiln.replacingOccurrences(of: " ", with: "_") + "_big"
}

struct StageNameLabel: View {
    
    var stageName: String
    var StageNameFontSize: CGFloat
    
    var body: some View {
        ZStack {
            Rectangle()
                .frame(width: 125, height: 25)
                .cornerRadius(6)
                .foregroundColor(.black)
                .opacity(0.75)
            
            Text(self.stageName)
                .shadow(radius: 10)
                .font(.custom("Splatoon2", size: self.StageNameFontSize))
                .foregroundColor(.white)
        }
    }
}

struct WideRotationItem_Previews: PreviewProvider {
    static var previews: some View {
        WideRotationView()
            .environmentObject(Env(isForTest: true))
            //                    .previewLayout(PreviewLayout.fixed(width:1194, height:834))
            .previewDevice(PreviewDevice(rawValue: "iPad Pro (12.9-inch) (3rd generation)"))
        //                    .preferredColorScheme(.light)
        //        WideStageCell(imgFiln: "Humpback Pump Track", stageName: "Humpback Pump Track", StageNameFontSize: 20, minCellWidth: 800, maxCellWidth: 800)
        //            .border(Color.black)
        //            .previewDevice(PreviewDevice(rawValue: "iPad Pro (12.9-inch) (3rd generation)"))
    }
}


