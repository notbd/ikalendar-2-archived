//
//  WideRotationContentView.swift
//  ikalendar2
//
//  Created by Tianwei Zhang on 8/31/20.
//  Copyright © 2020 Tianwei Zhang. All rights reserved.
//

import SwiftUI

struct WideRotationContentView: View {
    
//    @State var title: String
//    @State var content: String
//    var rotations: [Rotation]
    
    var body: some View {
        Form {
            
            Section(header: Text("title")) {
                Text("content")
            }
            
            Section(header: Text("title")) {
                Text("content")
            }
        }
    }
}

struct WideRotationContentView_Previews: PreviewProvider {
    static var previews: some View {
//        WideRotationContentView(title: "Test1", content: "Test2")
        WideRotationContentView()
    }
}
