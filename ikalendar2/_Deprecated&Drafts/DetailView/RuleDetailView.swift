//
//  RuleDetailView.swift
//  ikalendar2
//
//  Created by Tianwei Zhang on 4/17/21.
//

import SwiftUI

// MARK: - RuleDetailView

/// The view that displays the detail information of a match rule.
struct RuleDetailView: View {
  var rule: MatchRule

  var releaseDatePrefix: String { "Release Date" }
  var descriptionPrefix: String { "Description" }
  var body: some View {
    ScrollView {
      MapView(latitude: Coordinate2D.getRandomLatitude(),
              longitude: Coordinate2D.getRandomLongitude())
        .ignoresSafeArea(edges: .top)
        .frame(height: 300)

      CircleImage(image: Image(rule.imgFilnLarge))
        .offset(y: -130)
        .padding(.bottom, -130)

      VStack(alignment: .leading) {
        Text(rule.name)
          .font(.title)
          .foregroundColor(.primary)

        Divider()

        Text("\(releaseDatePrefix):")
          .font(.title2)
        Text(rule.releaseDate)
          .font(.title2)
        Spacer()
          .frame(height: 20)
        Text("\(descriptionPrefix):")
        Text(rule.description)
      }
      .padding()
    }
  }
}

// MARK: - RuleDetailView_Previews

struct RuleDetailView_Previews: PreviewProvider {
  static var previews: some View {
    RuleDetailView(rule: .splatZones)
  }
}
