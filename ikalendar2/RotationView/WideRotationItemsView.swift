//
//  WideRotationItemsView.swift
//  ikalendar2
//
//  Created by Tianwei Zhang on 8/31/20.
//  Copyright © 2020 Tianwei Zhang. All rights reserved.
//

import SwiftUI

struct WideRotationItemsView: View {
    
    var rotations: [Rotation]
    var singlePaddingConstant: CGFloat = 0.08
    
    var body: some View {
        GeometryReader { geometry in
            
            ScrollView {
                VStack(spacing: 30) {
                    ForEach (0 ..< self.rotations.count) { idx in
                        WideRotationItem(rotation: self.rotations[idx], index: idx, width: self.getWidthForRotationItem(width: geometry.size.width))
                    }
                    
                }
                .padding(.top,      60)
                .padding(.bottom,   60)
                .padding(.leading,  self.getWidthForSinglePadding(width: geometry.size.width))
                .padding(.trailing, self.getWidthForSinglePadding(width: geometry.size.width))
            }
        }
    }
    
    func getWidthForRotationItem(width: CGFloat) -> CGFloat {
        return width * (1 - 2 * singlePaddingConstant)
    }
    
    func getWidthForSinglePadding(width: CGFloat) -> CGFloat {
        return width * singlePaddingConstant
    }
}

struct WideRotationItemsView_Previews: PreviewProvider {
    static var previews: some View {
        WideRotationView()
            .environmentObject(Env(isForTest: true))
            .preferredColorScheme(.light)
    }
}
