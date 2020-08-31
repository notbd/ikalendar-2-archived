//
//  InfoScreenView.swift
//  ikalendar2
//
//  Created by Tianwei Zhang on 8/26/20.
//  Copyright © 2020 Tianwei Zhang. All rights reserved.
//

import SwiftUI

struct InfoScreenView: View {
    
    @EnvironmentObject var env: Data
    
    var body: some View {
        
        HStack {
            Spacer()
            
            // loading msg
            if env.loadingStatus == .loading {
                VStack(alignment: .leading) {
                    Text("Loading...")
                        .font(.system(.largeTitle, design: .rounded))
                    Text(   """
                            Make sure you are connected to the internet.
                            Tap the mode icon on the top to manually refresh.
                            """)
                        .font(.system(.caption, design: .rounded))
                }
            }
                
            // error msg
            else if env.loadingStatus == .failure {
                VStack(alignment: .leading) {
                    Text("Connection Error")
                        .font(.system(.largeTitle, design: .rounded))
                    Text(   """
                            Make sure you are connected to the internet.
                            Tap the mode icon on the top to manually refresh.
                            """)
                        .font(.system(.caption, design: .rounded))
                    
                }
            }
            
            Spacer()
        }
        .foregroundColor(.secondary)
        
    }
}

struct InfoScreenView_Previews: PreviewProvider {
    static var previews: some View {
        InfoScreenView()
            .environmentObject(Data(isForTest: true))
            .environment(\.colorScheme, .dark)
    }
}
