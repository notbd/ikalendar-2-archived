//
//  MyCustomText.swift
//  ikalendar2
//
//  Created by Tianwei Zhang on 9/6/20.
//  Copyright © 2020 Tianwei Zhang. All rights reserved.
//

import SwiftUI

struct SettingsBodySizedText<Content: View>: View {
    
    let content: Content
    
    init(@ViewBuilder content: () -> Content) {
        self.content = content()
    }
    
    var body: some View {
        Group {
            content
        }
        .font(.system(size: 14, weight: .regular, design: .rounded))
    }
}

struct SettingsHeaderSizedText<Content: View>: View {
    
    let content: Content
    
    init(@ViewBuilder content: () -> Content) {
        self.content = content()
    }
    
    var body: some View {
        Group {
            content
        }
        .font(.system(size: 11, weight: .medium, design: .rounded))
    }
}

struct SettingsFooterSizedText<Content: View>: View {
    
    let content: Content
    
    init(@ViewBuilder content: () -> Content) {
        self.content = content()
    }
    
    var body: some View {
        Group {
            content
        }
        .font(.system(size: 11, weight: .regular, design: .rounded))
    }
}

struct SettingsTinySizedText<Content: View>: View {
    
    let content: Content
    
    init(@ViewBuilder content: () -> Content) {
        self.content = content()
    }
    
    var body: some View {
        Group {
            content
        }
        .font(.system(size: 10, weight: .regular, design: .rounded))
    }
}

struct MyCustomText_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
            .environmentObject(Env(isForTest: true))
            .environment(\.colorScheme, .dark)
//            .environment(\.sizeCategory, .extraSmall)
    }
}
