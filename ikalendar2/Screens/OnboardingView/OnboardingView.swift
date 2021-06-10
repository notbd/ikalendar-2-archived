//
//  OnboardingView.swift
//  ikalendar2
//
//  Created by Tianwei Zhang on 9/2/20.
//  Copyright © 2020 Tianwei Zhang. All rights reserved.
//

import SwiftUI

// MARK: - OnboardingView

struct OnboardingView: View {
  @Environment(\.presentationMode) var presentationMode

  var body: some View {
    GeometryReader { geometry in

      HStack {
        Spacer()

        VStack {
          Spacer()

          // MARK: Title

          Text("Welcome Aboard")
            .font(.system(geometry.size.width > 320 ? .largeTitle : .title,
                          design: .rounded))
              .fontWeight(.bold)

          VStack(spacing: 24) {
            // MARK: Content

            BulletBlockView(title: "Map Schedules",
                            description: "Check out the stage rotations for your favorite 🦑 game!",
                            header: {
                              Image(systemName: "calendar")
                                .font(.largeTitle)
                                .foregroundColor(Color.accentColor)
                            })

            BulletBlockView(title: "Turf, Ranked and League",
                            description: "Salmon Run will be supported in future updates as well.",
                            header: {
                              Rotated3DOverlapView(top: {
                                Image(BattleMode.league.imgFilnSmall)
                                  .resizable()
                                  .scaledToFit()
                                  .shadow(radius: 5)
                                  .frame(width: 28)
                              }, mid: {
                                Image(BattleMode.gachi.imgFilnSmall)
                                  .resizable()
                                  .scaledToFit()
                                  .shadow(radius: 5)
                                  .frame(width: 28)
                              }, bottom: {
                                Image(BattleMode.regular.imgFilnSmall)
                                  .resizable()
                                  .scaledToFit()
                                  .shadow(radius: 10)
                                  .frame(width: 28)
                              }, xOffset: 16,
                              yOffset: 10,
                              rotDegrees: 40,
                              xAxisConstant: 1.5,
                              yAxisConstant: 1)
                            })

            BulletBlockView(title: "iOS Universal",
                            description: "Placeholder here.",
                            header: {
                              Image(systemName: "guitars")
                                .font(.largeTitle)
                                .foregroundColor(Color.accentColor)
                            })

            BulletBlockView(title: "Dark Mode Supported",
                            description: "Placeholder here.",
                            header: {
                              Image(systemName: "moon.stars.fill")
                                .font(.largeTitle)
                                .foregroundColor(Color(UIColor.systemYellow))
                            })
          }
          .padding(.top, geometry.size.width > 320 ? 30 : 10)
          .padding(.top, geometry.size.width > 375 ? 20 : 0)
          .padding(.bottom, 20)

          Spacer()

          VStack(spacing: 12) {
            HStack {
              Image(systemName: "pencil.and.outline")
              Text("·")
              Text("Coded by 彼得張 / Peter Zhang")
                .foregroundColor(.primary)
            }
            .font(.system(size: 10, design: .serif))

            // MARK: Dismiss Button

            Button {
              Haptics.generate(.success)
              self.presentationMode.wrappedValue.dismiss()
            } label: {
              Text("Continue")
                .foregroundColor(.white)
                .font(.system(.body, design: .rounded))
                .fontWeight(.semibold)

                .frame(maxWidth: geometry.size.width > 320 ? 360 : 240)
                .frame(height: geometry.size.width > 320 ? 48 : 42)

                .background(Color.accentColor)
                .cornerRadius(12)
                .shadow(radius: 6)
            }
          }
        }
        .padding(.bottom, geometry.size.width > 414 ? 40 : 20)
        .padding(.leading, geometry.size.width > 320 ? 30 : 20)
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

// MARK: - BulletBlockView

struct BulletBlockView<Content: View>: View {
  let header: Content
  let title: String
  let description: String

  var body: some View {
    HStack {
      header
        .frame(width: 60)

      VStack(alignment: .leading, spacing: 2) {
        Text(title)
          .font(.system(.subheadline, design: .rounded))
          .fontWeight(.semibold)
          .lineLimit(1)
        Text(description)
          .foregroundColor(.secondary)
          .font(.system(.caption, design: .rounded))
          .lineLimit(3)
      }

      Spacer()
    }
  }

  // MARK: Lifecycle

  init(title: String, description: String, @ViewBuilder header: () -> Content) {
    self.header = header()
    self.title = title
    self.description = description
  }
}

// MARK: - Rotated3DOverlapView

struct Rotated3DOverlapView<Content: View>: View {
  let top: Content
  let mid: Content
  let bottom: Content
  let xOffset: CGFloat
  let yOffset: CGFloat
  let rotDegrees: Double
  let xAxisConstant: CGFloat
  let yAxisConstant: CGFloat

  var body: some View {
    ZStack {
      bottom
        .rotation3DEffect(.degrees(rotDegrees),
                          axis: (x: xAxisConstant, y: yAxisConstant, z: 0))
          .offset(x: -xOffset, y: -yOffset)
      mid
        .rotation3DEffect(.degrees(rotDegrees),
                          axis: (x: xAxisConstant, y: yAxisConstant, z: 0))
      top
        .rotation3DEffect(.degrees(rotDegrees),
                          axis: (x: xAxisConstant, y: yAxisConstant, z: 0))
          .offset(x: xOffset, y: yOffset)
    }
  }

  // MARK: Lifecycle

  init(
    @ViewBuilder top: () -> Content,
    @ViewBuilder mid: () -> Content,
    @ViewBuilder bottom: () -> Content,
    xOffset: CGFloat,
    yOffset: CGFloat,
    rotDegrees: Double,
    xAxisConstant: CGFloat,
    yAxisConstant: CGFloat)
  {
    self.top = top()
    self.mid = mid()
    self.bottom = bottom()
    self.xOffset = xOffset
    self.yOffset = yOffset
    self.rotDegrees = rotDegrees
    self.xAxisConstant = xAxisConstant
    self.yAxisConstant = yAxisConstant
  }
}

// MARK: - WelcomeView_Previews

struct WelcomeView_Previews: PreviewProvider {
  static var previews: some View {
    OnboardingView()
      .preferredColorScheme(.dark)
      .previewDevice(PreviewDevice(rawValue: "iPhone 11 Pro"))
    //        .previewDevice(PreviewDevice(rawValue: "iPad Pro (12.9-inch) (3rd generation)"))
  }
}
