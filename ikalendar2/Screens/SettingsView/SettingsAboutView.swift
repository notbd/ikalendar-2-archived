//
//  SettingsAboutView.swift
//  ikalendar2
//
//  Created by Peter Zhang on 6/7/21.
//  Copyright © 2021 Tianwei Zhang. All rights reserved.
//

import StoreKit
import SwiftUI

// MARK: - SettingsAboutView

/// The About page in App Settings.
struct SettingsAboutView: View {
  @Environment(\.openURL) var openURL

  @State var appStoreOverlayPresented = false

  var body: some View {
    Form {
      Section(header: Spacer()) {
        iconContent
      }

      Section(header: Text("Share")) {
        rowShare
      }

      Section(header: Text("Contact")) {
        rowDeveloperTwitter
        rowDeveloperEmail
      }

      Section(header: Text("Review")) {
        rowAppStoreOverlay
        rowGiveRate
        rowLeaveReview
      }

      Section(header: Text("Others")) {
        rowSourceCode
        rowPrivacyPolicy
      }
    }
    .roundedFont()
    .navigationTitle("About")
    .navigationBarTitleDisplayMode(.inline)
  }

  // MARK: - Components ↓↓↓

  // MARK: - Icon Section

  var iconContent: some View {
    HStack {
      Spacer()
      iconLabel
        .padding()
      Spacer()
    }
  }

  var iconLabel: some View {
    var iconImage: some View {
      Image(uiImage: UIImage(named: "AppIcon-1") ?? UIImage())
        .resizable()
        .scaledToFit()
        .frame(width: 120, height: 120)
        .cornerRadius(16)
    }

    var iconTitle: some View {
      let elements = ["ikalendar", Constants.Keys.appVersion]
      let title = elements.joined(separator: " ")
      let text = Text(title)
        .foregroundColor(.accentColor)
        .fontWeight(.bold)
        .font(.system(.largeTitle, design: .rounded))
      return text
    }

    var iconSubtitle: some View {
      let elements = ["Build", Constants.Keys.appBuildNumber]
      let subtitle = elements.joined(separator: " ")
      let text = Text(subtitle)
        .foregroundColor(.secondary)
        .fontWeight(.regular)
        .font(.system(.subheadline, design: .rounded))
      return text
    }

    return VStack(alignment: .center) {
      iconImage
      iconTitle
      iconSubtitle
    }
  }

  // MARK: - Share Section

  var rowShare: some View {
    Button {
      Haptics.generate(.selection)
      didTapShare()
    } label: {
      Label(title: {
              Text("Share ikalendar2")
                .foregroundColor(.primary)
            },

            icon: {
              Image(systemName: "square.and.arrow.up")
                .foregroundColor(.accentColor)
            })
    }
  }

  // MARK: - Contact Section

  var rowDeveloperTwitter: some View {
    Button {
      Haptics.generate(.selection)
      if let url = URL(string: Constants.Keys.URL.DEVELOPER_TWITTER) {
        openURL(url)
      }
    } label: {
      Label(title: {
              HStack {
                Text("Developer's Twitter")
                  .foregroundColor(.primary)
                Spacer()
                Text("@gppppa_")
                  .foregroundColor(.secondary)
              }
            },

            icon: {
              Image(systemName: "person.fill")
                .foregroundColor(.blue)
            })
    }
  }

  var rowDeveloperEmail: some View {
    Button {
      Haptics.generate(.selection)
      if let url = URL(string: Constants.Keys.URL.DEVELOPER_EMAIL) {
        openURL(url)
      }
    } label: {
      Label(title: {
              Text("Send Feedback Email")
                .foregroundColor(.primary)
            },

            icon: {
              Image(systemName: "envelope")
                .foregroundColor(.blue)
            })
    }
  }

  // MARK: - Review Section

  var rowAppStoreOverlay: some View {
    Button {
      Haptics.generate(.selection)
      appStoreOverlayPresented.toggle()
    } label: {
      Label(title: {
              Text("View ikalendar2 on the App Store")
                .foregroundColor(.primary)
            },

            icon: {
              Image(systemName: "doc.text.fill.viewfinder")
                .foregroundColor(.accentColor)
            })
    }
    .appStoreOverlay(isPresented: $appStoreOverlayPresented) {
      SKOverlay.AppConfiguration(appIdentifier: "1529193361", position: .bottom)
    }
  }

  var rowGiveRate: some View {
    Button {
      Haptics.generate(.selection)
      didTapRate()
    } label: {
      Label(title: {
              Text("Rate on the App Store")
                .foregroundColor(.primary)
            },

            icon: {
              Image(systemName: "star.fill")
                .foregroundColor(.yellow)
            })
    }
  }

  var rowLeaveReview: some View {
    Button {
      Haptics.generate(.selection)
      if let url = URL(string: Constants.Keys.URL.APP_STORE_REVIEW) {
        openURL(url)
      }
    } label: {
      Label(title: {
              Text("Leave a Review")
                .foregroundColor(.primary)
            },

            icon: {
              Image(systemName: "highlighter")
                .foregroundColor(.accentColor)
            })
    }
  }

  // MARK: - Others Section

  var rowSourceCode: some View {
    Button {
      Haptics.generate(.selection)
      if let url = URL(string: Constants.Keys.URL.SOURCE_CODE_REPO) {
        openURL(url)
      }
    } label: {
      Label(title: {
              Text("Source Code")
                .foregroundColor(.primary)
            },

            icon: {
              Image(systemName: "chevron.left.slash.chevron.right")
                .foregroundColor(.blue)
            })
    }
  }

  var rowPrivacyPolicy: some View {
    Button {
      Haptics.generate(.selection)
      if let url = URL(string: Constants.Keys.URL.PRIVACY_POLICY) {
        openURL(url)
      }
    } label: {
      Label(title: {
              Text("Privacy Policy")
                .foregroundColor(.primary)
            },

            icon: {
              Image(systemName: "hand.raised.fill")
                .foregroundColor(.blue)
            })
    }
  }

  // MARK: - End Components ↑↑↑

  // MARK: Internal

  /// Handle the tap on the share button.
  func didTapShare() {
    guard let shareURL = URL(string: Constants.Keys.URL.APP_STORE_PAGE) else { return }
    let activityVC = UIActivityViewController(activityItems: [shareURL], applicationActivities: nil)
    let keyWindow = UIApplication.shared.windows.filter(\.isKeyWindow).first
    if var topController = keyWindow?.rootViewController {
      while let presentedViewController = topController.presentedViewController {
        topController = presentedViewController
      }
      topController.present(activityVC, animated: true,
                            completion: nil)
    }
  }

  /// Handle the tap on the rate button.
  func didTapRate() {
    if
      let scene = UIApplication.shared.connectedScenes
        .first(where: { $0.activationState == .foregroundActive }) as? UIWindowScene
    {
      SKStoreReviewController.requestReview(in: scene)
    }
  }
}

// MARK: - SettingsAboutView_Previews

struct SettingsAboutView_Previews: PreviewProvider {
  static var previews: some View {
    Group {
      SettingsAboutView()
        .preferredColorScheme(.dark)
    }
  }
}
