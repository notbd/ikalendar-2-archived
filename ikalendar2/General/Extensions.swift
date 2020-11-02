//
//  Extensions.swift
//  ikalendar2
//
//  Created by Tianwei Zhang on 9/8/20.
//  Copyright © 2020 Tianwei Zhang. All rights reserved.
//

import SwiftUI
import UIKit

extension Binding {
    func myAddActionOnChange(_ handler: @escaping () -> Void) -> Binding<Value> {
        return Binding(
            get: { self.wrappedValue },
            set: { selection in
                self.wrappedValue = selection
                handler()
        })
    }
}

extension Date {

    static func - (lhs: Date, rhs: Date) -> TimeInterval {
        return lhs.timeIntervalSinceReferenceDate - rhs.timeIntervalSinceReferenceDate
    }

}

extension TimeInterval {
    
    func toRotationRemainingTimeString(alwaysIncludeSeconds:Bool = false) -> String {
        var result = ""
        
        let interval = Int(self)
        
        // handle if rotation end time passed
        if interval < 0 {
            return "0s"
        }
        
        let seconds = interval % 60
        let minutes = (interval / 60) % 60
        let hours = interval / 3600
        
        if hours > 0 {
            result += "\(hours)h "
        }
        
        if hours > 0 || minutes > 0 {
            result += "\(minutes)m"
        }
        
        if alwaysIncludeSeconds || hours == 0 {
            result += " \(seconds)s"
        }
        
        return result
    }
}

struct MbModalHackView: UIViewControllerRepresentable {
    var dismissable: () -> Bool = { false }
    
    func makeUIViewController(context: UIViewControllerRepresentableContext<MbModalHackView>) -> UIViewController {
        UIViewController()
    }
    func updateUIViewController(_ uiViewController: UIViewController, context: UIViewControllerRepresentableContext<MbModalHackView>) {
        rootViewController(of: uiViewController).presentationController?.delegate = context.coordinator
    }
    private func rootViewController(of uiViewController: UIViewController) -> UIViewController {
        if let parent = uiViewController.parent {
            return rootViewController(of: parent)
        }
        else {
            return uiViewController
        }
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(dismissable: dismissable)
    }
    
    class Coordinator: NSObject, UIAdaptivePresentationControllerDelegate {
        var dismissable: () -> Bool = { false }
        
        init(dismissable: @escaping () -> Bool) {
            self.dismissable = dismissable
        }
        
        func presentationControllerShouldDismiss(_ presentationController: UIPresentationController) -> Bool {
            dismissable()
        }
    }
}

/// view.allowAutDismiss(...)
extension View {
    public func allowAutoDismiss(_ dismissable: @escaping () -> Bool) -> some View {
        self
            .background(MbModalHackView(dismissable: dismissable))
    }
}
