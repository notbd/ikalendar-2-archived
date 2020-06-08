//
//  RotationItem.swift
//  ikalendar2
//
//  Created by Tianwei Zhang on 5/10/20.
//  Copyright © 2020 Tianwei Zhang. All rights reserved.
//

import SwiftUI

struct RotationItem: View {
    
    var rotation:Rotation
    
    var body: some View {
        HStack {
            
            VStack(alignment: .leading, spacing: 10) {
                HStack {
                    Image(rotation.rule_filn.rawValue)
                        .resizable()
                        .antialiased(true)
                        .scaledToFit()
                        .shadow(radius: 5)
                        .frame(width: 32)
                    
                    Text(rotation.rule.rawValue)
                        .font(.custom("Splatoon2", size: 14))
                    Spacer()
                }.frame(width: 120)
                Text(rotation.time)
                    .font(.custom("Splatoon2", size: 14))
            }.frame(width: 120)
            
            Spacer()
            
            VStack(alignment: .trailing, spacing: 5) {
                Image(rotation.map_1_filn)
                    .resizable()
                    .scaledToFit()
                    .cornerRadius(5)
                    .shadow(radius: 5)
                    .frame(width: 100)
                Text(rotation.map_1_name)
                    .font(.custom("Splatoon2", size: 10))
            }
            
            Spacer()
            
            VStack(alignment: .trailing, spacing: 5) {
                Image(rotation.map_2_filn)
                    .resizable()
                    .scaledToFit()
                    .cornerRadius(5)
                    .shadow(radius: 5)
                    .frame(width: 100)
                Text(rotation.map_2_name)
                    .font(.custom("Splatoon2", size: 10))
            }
            
        }
    }
}

struct RotationItem_Previews: PreviewProvider {
    static var previews: some View {
//        RotationItem(rotation: rotationData[1])
        RotationView(rotations: rotationData)
    }
}
