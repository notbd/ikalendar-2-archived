//
//  SwiftUIBlur.swift
//  ikalendar2
//
//  Created by Tianwei Zhang on 4/1/21.
//

import SwiftUI

// MARK: - Blur

/// A custom view that blurs the content underneath.
struct Blur: UIViewRepresentable {
  var style: UIBlurEffect.Style = .systemMaterial

  // MARK: Internal

  func makeUIView(context _: Context) -> UIVisualEffectView {
    UIVisualEffectView(effect: UIBlurEffect(style: style))
  }

  func updateUIView(_ uiView: UIVisualEffectView, context _: Context) {
    uiView.effect = UIBlurEffect(style: style)
  }
}

// MARK: - SwiftUIBlur_Previews

struct SwiftUIBlur_Previews: PreviewProvider {
  static var previews: some View {
    ZStack {
      Text("background")
        .font(.largeTitle)

      Text("Test")
        .font(.largeTitle)
        .padding()
        .background(Blur(style: .systemChromeMaterial))
    }
  }
}
