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
    
    var body: some View {
        
        Section(header:
            HStack {
                
                if index == 0 {
                    Text("Now:")
                        .font(.custom("Splatoon2", size: 14))
                } else if index == 1 {
                    Text("Next:")
                        .font(.custom("Splatoon2", size: 14))
                }
                
                Text(rotation.time)
                    .font(.custom("Splatoon2", size: 12))
                    .foregroundColor(.secondary)
        }) {
            HStack {
                
                HStack {
                    Image(rotation.rule_filn)
                        .resizable()
                        .antialiased(true)
                        .scaledToFit()
                        .shadow(radius: 5)
                        .frame(width: 35, height: 35)
                    Spacer()
                    Text(rotation.rule)
                        .font(.custom("Splatoon2", size: 14))
                    Spacer()
                    
                }
                .frame(width: 130)
                
                Spacer()
                
                VStack(alignment: .trailing, spacing: 0) {
                    Image(rotation.stage_1_filn)
                        .resizable()
                        .scaledToFit()
                        .cornerRadius(5)
                        .shadow(radius: 5)
                        .frame(width: 100)
                    
                    
                    Text(rotation.stage_1_name)
                        .font(.custom("Splatoon2", size: 10))
                }
                .offset(x: 0, y: 6)
                
                Spacer()
                
                VStack(alignment: .trailing, spacing: 0) {
                    Image(rotation.stage_2_filn)
                        .resizable()
                        .scaledToFit()
                        .cornerRadius(5)
                        .shadow(radius: 5)
                        .frame(width: 100)
                    Text(rotation.stage_2_name)
                        .font(.custom("Splatoon2", size: 10))
                }
                .offset(x: 0, y: 6)
                
            }.frame(height: 80)
        }
    }
}

struct WideRotationItem_Previews: PreviewProvider {
    static var previews: some View {
        WideRotationView()
            .environmentObject(Data(isForTest: true))
            .preferredColorScheme(.light)
    }
}
