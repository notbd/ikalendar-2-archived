//
//  WhatsNewView.swift
//  ikalendar2
//
//  Created by Tianwei Zhang on 11/1/20.
//  Copyright © 2020 Tianwei Zhang. All rights reserved.
//

import SwiftUI

struct WhatsNewView: View {
    
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        
        GeometryReader { geometry in
            
            HStack {
                
                Spacer()
                
                VStack {
                    
                    Spacer()
                    
                    // MARK: Title
                    Text("What's New")
                        .font(.system( geometry.size.width > 320 ? .largeTitle : .title, design: .rounded))
                        .fontWeight(.bold)
                    
                    
                    VStack(spacing: 24) {
                        
                        // MARK: Content
                        BulletBlockView(title: "Optimized for 14",
                                        description: "Our code base has been rewritten to get the best out of iOS14.",
                                        header: {
                                            Image(systemName: "14.square.fill")
                                                .font(.largeTitle)
                                                .foregroundColor(Color.primary)
                        })
                        
                        BulletBlockView(title: "Refreshed Layout",
                                        description: "The new layout adds up to easier and better app visual.",
                                        header: {
                                            Image(systemName: "crop.rotate")
                                                .font(.largeTitle)
                                                .foregroundColor(Color.primary)
                        })
                        
                        BulletBlockView(title: "How much time left?",
                                        description: "ikalendar2 now shows the time remaining for current rotation in real time.",
                                        header: {
                                            Image(systemName: "stopwatch.fill")
                                                .font(.largeTitle)
                                                .foregroundColor(Color.primary)
                        })
                        
                    }
                    .padding(.top, geometry.size.width > 320 ? 30 : 10)
                    .padding(.top, geometry.size.width > 375 ? 20 : 0)
                    .padding(.bottom, 20)
                    
                    Spacer()
                    
                    
                    VStack(spacing: 12) {
                        
                        HStack {
                            Image(systemName: "pencil.tip.crop.circle")
                            Text("·")
                            Text("Version \(Constants.appVersion ?? "?") Build \(Constants.appBuildNumber ?? "?")")
                        }
                        .font(.system(size: 10, design: .serif))
                        .foregroundColor(.primary)
                            
                        // MARK: Dismiss Button
                        
                        Button(action: {
                            simpleHapticSuccess()
                            self.presentationMode.wrappedValue.dismiss()
                        }) {
                            Text("Continue")
                                .foregroundColor(.white)
                                .font(.system(.body, design: .rounded))
                                .fontWeight(.semibold)
                                
                                .frame(maxWidth:    geometry.size.width > 320 ? 360 : 240)
                                .frame(height:      geometry.size.width > 320 ? 48  : 42)
                            
                                .background(Color.accentColor)
                                .cornerRadius(12)
                                .shadow(radius: 6)
                            
                        }
                    }
                }
                .padding(.bottom,   geometry.size.width > 414 ? 40 : 20)
                .padding(.leading,  geometry.size.width > 320 ? 30 : 20)
                .padding(.trailing, geometry.size.width > 320 ? 30 : 20)
                    
//                .padding(.leading,  geometry.size.width > 375 ? 5 : 0)
//                .padding(.trailing, geometry.size.width > 375 ? 5 : 0)
                .frame(maxWidth: 512)
                
                Spacer()
                
            }
            .allowAutoDismiss { false }
        }
    }
}

struct WhatsNewView_Previews: PreviewProvider {
    static var previews: some View {
        WhatsNewView()
    }
}
