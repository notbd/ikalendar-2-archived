//
//  RotationView.swift
//  ikalendar2
//
//  Created by Tianwei Zhang on 5/9/20.
//  Copyright © 2020 Tianwei Zhang. All rights reserved.
//

import SwiftUI

struct RotationView: View {
    
    @State private var selectedMode = 1
    
    var mode = ["Turf", "Ranked", "League"]
    var modeTitle = ["Regular Battle", "Ranked Battle", "League Battle"]
    var modeImgName = ["turf_small", "ranked_small", "league_small"]
    
    init() {

            let largeTitleFontSize: CGFloat = 34
            let titleTextFontSize: CGFloat = 17
        
            // Here we get San Francisco with the desired weight
            let systemLargeTitleFont = UIFont.systemFont(ofSize: largeTitleFontSize, weight: .bold)
            let systemTitleTextFont = UIFont.systemFont(ofSize: titleTextFontSize, weight: .bold)

            // Will be SF Compact or standard SF in case of failure.
            let largeTitleFont, titleTextFont: UIFont

            if let descriptor = systemLargeTitleFont.fontDescriptor.withDesign(.rounded) {
                largeTitleFont = UIFont(descriptor: descriptor, size: largeTitleFontSize)
            } else {
                largeTitleFont = systemLargeTitleFont
            }

            if let descriptor = systemTitleTextFont.fontDescriptor.withDesign(.rounded) {
                titleTextFont = UIFont(descriptor: descriptor, size: titleTextFontSize)
            } else {
                titleTextFont = systemTitleTextFont
            }

            UINavigationBar.appearance().largeTitleTextAttributes = [
                .font : largeTitleFont]


            UINavigationBar.appearance().titleTextAttributes = [
                .font : titleTextFont]
        

        }
    
    
    var body: some View {
        
        NavigationView {
            
                List {
                    
                    Picker("Mode", selection: $selectedMode) {
                        ForEach(0 ..< mode.count) { index in
                            Text(self.mode[index])
                                .tag(index)
                        }
                    }.pickerStyle(SegmentedPickerStyle())
                    
                    HStack {
                        VStack(alignment: .trailing, spacing: 10) {
                            HStack {
                                Image("TC_small")
                                    .resizable()
                                    .antialiased(true)
                                    .scaledToFit()
                                    .shadow(radius: 5)
                                    .frame(width: 30)
                                
                                Text("ガチヤグラ")
                                    .font(.custom("Splatoon2", size: 16))
                                Spacer()
                            }
                            
                            Text("0:00-2:00")
                                .font(.custom("Splatoon2", size: 12))
                            
                        }.frame(width: 130)
                        
                        Spacer()
                        
                        VStack(alignment: .trailing, spacing: 5) {
                            Image("Musselforge_Fitness_small")
                                .resizable()
                                .scaledToFit()
                                .cornerRadius(5)
                                .shadow(radius: 5)
                                .frame(width: 100)
                            Text("Musselforge Fitness")
                                .font(.custom("Splatoon2", size: 10))
                        }
                        
                        Spacer()
                        
                        VStack(alignment: .trailing, spacing: 5) {
                            Image("The_Reef_small")
                                .resizable()
                                .scaledToFit()
                                .cornerRadius(5)
                                .shadow(radius: 5)
                                .frame(width: 100)
                            Text("The Reef")
                                .font(.custom("Splatoon2", size: 10))
                        }
                    }
                    
                    HStack {
                        VStack(alignment: .trailing, spacing: 10) {
                            HStack {
                                Image("CB_small")
                                    .resizable()
                                    .antialiased(true)
                                    .scaledToFit()
                                    .shadow(radius: 5)
                                    .frame(width: 30)
                                
                                Text("ガチアサリ")
                                    .font(.custom("Splatoon2", size: 16))
                                Spacer()
                            }
                            
                            Text("2:00-4:00")
                                .font(.custom("Splatoon2", size: 12))
                            
                        }.frame(width: 130)
                        
                        Spacer()
                        
                        VStack(alignment: .trailing, spacing: 5) {
                            Image("Moray_Towers_small")
                                .resizable()
                                .scaledToFit()
                                .cornerRadius(5)
                                .shadow(radius: 5)
                                .frame(width: 100)
                            Text("Moray Tower")
                                .font(.custom("Splatoon2", size: 10))
                        }
                        
                        Spacer()
                        
                        VStack(alignment: .trailing, spacing: 5) {
                            Image("MakoMart_small")
                                .resizable()
                                .scaledToFit()
                                .cornerRadius(5)
                                .shadow(radius: 5)
                                .frame(width: 100)
                            Text("MakoMart")
                                .font(.custom("Splatoon2", size: 10))
                        }
                        
                    }
                    
                    
                }
                .navigationBarTitle(Text(modeTitle[selectedMode]))
                .navigationBarItems(
                    leading: Image(modeImgName[selectedMode])
                                .resizable()
                                .scaledToFit()
                                .shadow(radius: 5)
                                .frame(width: 25))
            }
            
    }
}

struct RotationView_Previews: PreviewProvider {
    static var previews: some View {
        RotationView()
    }
}
