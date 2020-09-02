//
//  InfoScreenView.swift
//  ikalendar2
//
//  Created by Tianwei Zhang on 8/26/20.
//  Copyright © 2020 Tianwei Zhang. All rights reserved.
//

import SwiftUI

struct InfoScreenView: View {
    
    @EnvironmentObject var env: Env
    
    var body: some View {
        
        HStack {
            Spacer()
            
            // loading msg
            if env.loadingStatus == .loading {
                VStack(alignment: .leading) {
                    Text(Constants.LOADING_TITLE)
                        .font(.system(.largeTitle, design: .rounded))
                    Text(Constants.LOADING_MSG)
                        .font(.system(.caption, design: .rounded))
                }
            }
                
            // error msg
            else if env.loadingStatus == .failure {
                VStack(alignment: .leading) {
                    Text(Constants.FAILURE_TITLE)
                        .font(.system(.largeTitle, design: .rounded))
                    Text(Constants.FAILURE_MSG)
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
            .environmentObject(Env(isForTest: true))
            .environment(\.colorScheme, .dark)
    }
}
