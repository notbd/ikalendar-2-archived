//
//  LoadingAnimation.swift
//  ikalendar2
//
//  Created by Tianwei Zhang on 9/8/20.
//  Copyright © 2020 Tianwei Zhang. All rights reserved.
//

import SwiftUI

struct LoadingAnimation: View {
    let timer = Timer.publish(every: 0.35, on: .main, in: .common).autoconnect()
    @State var leftOffset: CGFloat  = -10
    @State var rightOffset: CGFloat = 10
    var circleSize: CGFloat = 3
    
    var body: some View {
        ZStack {
            Circle()
                .fill(Color.black)
                .frame(width: circleSize, height: circleSize)
                .offset(x: leftOffset)
                .opacity(0.7)
                .animation(Animation.easeInOut(duration: 0.2))
            Circle()
                .fill(Color.black)
                .frame(width: circleSize, height: circleSize)
                .offset(x: leftOffset)
                .opacity(0.7)
                .animation(Animation.easeInOut(duration: 1).delay(0.05))
            Circle()
                .fill(Color.black)
                .frame(width: circleSize, height: circleSize)
                .offset(x: leftOffset)
                .opacity(0.7)
                .animation(Animation.easeInOut(duration: 1).delay(0.1))
        }
        .onReceive(timer) { (_) in
            swap(&self.leftOffset, &self.rightOffset)
        }
    }
}

struct LoadingAnimation_Previews: PreviewProvider {
    static var previews: some View {
        LoadingAnimation()
    }
}
