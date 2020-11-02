//
//  WideRotationItem.swift
//  ikalendar2
//
//  Created by Tianwei Zhang on 8/31/20.
//  Copyright © 2020 Tianwei Zhang. All rights reserved.
//

import SwiftUI

struct WideRotationItem: View {
    
    @EnvironmentObject private var env: Env
    
    var rotation: Rotation
    var index: Int
//    var width: CGFloat
    
    var ExtraHeaderFontSize: CGFloat            { 18 }
    var TimeStringFontSize: CGFloat             { 14 }
    var RuleTitleFontSize: CGFloat              { 22 }
    var StageNameFontSize: CGFloat              { 12 }
    var RemainingTimeStringFontSize: CGFloat    { 16 }
    
    var RuleImgWidth: CGFloat                   { 40 }
    
    var ExtraHeaderYOffset: CGFloat             { 3 }
    
    // Spacings
    var RuleSectionSpacing: CGFloat             { 14 }
    var RuleAndStageSectionSpacing: CGFloat     { 2 }
    var StageSectionSpacing: CGFloat            { 40 }
    
    
    
    @State var remainTimeString: String = ""
    // StageCell Parameters
//    var minStageCellWidth: CGFloat              { width / 2 - 100 }
//    var maxStageCellWidth: CGFloat              { width / 2 - 100 }
    
    var body: some View {
        
        Group {
            
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
            )
            {
                // Content
                VStack(spacing: RuleAndStageSectionSpacing) {
                    
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
                        
                        if index == 0 {
                            Text(remainTimeString)
                                .font(.custom("Splatoon2", size: RemainingTimeStringFontSize))
                                .foregroundColor(.secondary)
                                .onReceive(env.refreshTimer) { _ in
                                    updateTimeString()
                                }
                                .onAppear {
                                    updateTimeString()
                                }
                        }
                    }
                    
                    Spacer()
                    
                    // Stage Section
                    HStack(alignment: .center, spacing: StageSectionSpacing) {
                        WideStageCell(imgFiln: rotation.stage_1_filn, stageName: rotation.stage_1_name, StageNameFontSize: StageNameFontSize)
                        
                        Spacer()
                        
                        WideStageCell(imgFiln: rotation.stage_2_filn, stageName: rotation.stage_2_name, StageNameFontSize: StageNameFontSize)
                    }
                }
                .padding(.top, 8)
                .padding(.bottom)
                .padding(.leading, 6)
                .padding(.trailing, 6)
            }
//            Divider()
        }
    }
    
    func updateTimeString() {
        guard let currRotationEndTime = self.env.currRotationEndTime else { return }
        let currTime = Date()
        self.remainTimeString = (currRotationEndTime - currTime).toRotationRemainingTimeString(alwaysIncludeSeconds: true) + " remaining"
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
                .cornerRadius(6)
                .foregroundColor(.black)
                .opacity(0.7)
            
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


