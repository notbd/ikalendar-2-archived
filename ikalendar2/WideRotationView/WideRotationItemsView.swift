//
//  WideRotationItemsView.swift
//  ikalendar2
//
//  Created by Tianwei Zhang on 8/31/20.
//  Copyright © 2020 Tianwei Zhang. All rights reserved.
//

import SwiftUI

struct WideRotationItemsView: View {
    
    @EnvironmentObject private var env: Env
    
    var rotations: [Rotation]
    
    private let singlePaddingConstant: CGFloat = 0.08
    
    var body: some View {
        
//        GeometryReader { geometry in
            List {
                ForEach (0 ..< self.rotations.count, id: \.self) { idx in
                    WideRotationItem(rotation: self.rotations[idx], index: idx)
                }
            }
            .listStyle(InsetGroupedListStyle())
//        }
    }
    
//    func getWidthForRotationItem(width: CGFloat) -> CGFloat {
//        return width * (1 - 2 * singlePaddingConstant)
//    }
//    
//    func getWidthForSinglePadding(width: CGFloat) -> CGFloat {
//        return width * singlePaddingConstant
//    }
}

struct WideRotationItemsView_Previews: PreviewProvider {
    static var previews: some View {
        WideRotationView()
            .environment(\.horizontalSizeClass, .regular)
            .environmentObject(Env(isForTest: true))
            .preferredColorScheme(.light)
    }
}
