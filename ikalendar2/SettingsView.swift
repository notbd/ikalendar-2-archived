//
//  SettingsView.swift
//  ikalendar2
//
//  Created by Tianwei Zhang on 5/9/20.
//  Copyright © 2020 Tianwei Zhang. All rights reserved.
//

import SwiftUI

struct SettingsView: View {
    
    @State var firstToggle = false
    @State var secondToggle = false
    @State var thirdToggle = false
    
    var body: some View {
        NavigationView {
            List {
                
                Toggle(isOn: $firstToggle) {
                    Text("First toggle")
                }
                
                Toggle(isOn: $secondToggle) {
                    Text("Second toggle")
                }
                
                Toggle(isOn: $thirdToggle) {
                    Text("Third toggle")
                }
                
                
                
            }.navigationBarTitle(Text("Settings"))
        }.font(.system(.body, design: .rounded))
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
