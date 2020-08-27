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
    
    var body: some View {
        
        HStack {
            
            VStack(
                alignment: .trailing,
                spacing: 12) {
                    HStack {
                        Image(rotation.rule_filn)
                            .resizable()
                            .antialiased(true)
                            .scaledToFit()
                            .shadow(radius: 5)
                            .frame(width: 36, height: 36)
                        Spacer()
                        Text(rotation.rule)
                            .font(.custom("Splatoon2", size: 13))
//                            .font(.system(size: 12, weight: .medium, design: .rounded))
                        Spacer()
                        
                    }
                    .frame(height: 32)
                    HStack {
                        Spacer()
                        Text(rotation.time)
                            .font(.custom("Splatoon2", size: 15))
//                            .font(.system(size: 16, weight: .medium, design: .rounded))
                        Spacer()
                    }
            }.frame(width: 128)
            
            Spacer()
            
            VStack(alignment: .trailing, spacing: 2) {
                Spacer()
                Image(rotation.stage_1_filn)
                    .resizable()
                    .scaledToFit()
                    .cornerRadius(5)
                    .shadow(radius: 5)
                
                Text(rotation.stage_1_name)
                    .font(.custom("Splatoon2", size: 10))
            }.frame(width: 100)
            
            Spacer()
            
            VStack(alignment: .trailing, spacing: 2) {
                Spacer()
                Image(rotation.stage_2_filn)
                    .resizable()
                    .scaledToFit()
                    .cornerRadius(5)
                    .shadow(radius: 5)
                
                Text(rotation.stage_2_name)
                    .font(.custom("Splatoon2", size: 10))
            }.frame(width: 100)
            
        }.frame(height: 90)
    }
}

struct RotationItem_Previews: PreviewProvider {
    static var previews: some View {
        RotationView()
            .environmentObject(Data(isForTest: true))
            .environment(\.colorScheme, .dark)
    }
}
