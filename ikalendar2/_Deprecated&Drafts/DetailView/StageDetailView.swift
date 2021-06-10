//
//  StageDetailView.swift
//  ikalendar2
//
//  Created by Tianwei Zhang on 4/17/21.
//

import SwiftUI

// MARK: - StageDetailView

/// The view that displays the detail information of a battle stage.
struct StageDetailView: View {
  var stage: BattleStage

  var releaseDatePrefix: String { "Release Date" }
  var inkableAreaPrefix: String { "Inkable Area" }
  var body: some View {
    ScrollView {
      MapView(latitude: Coordinate2D.getRandomLatitude(),
              longitude: Coordinate2D.getRandomLongitude())
        .ignoresSafeArea(edges: .top)
        .frame(height: 300)

      CircleImage(image: Image(stage.imgFilnLarge))
        .offset(y: -130)
        .padding(.bottom, -130)

      VStack(alignment: .leading) {
        Text(stage.name)
          .font(.title)
          .foregroundColor(.primary)

        Divider()

        Text("\(releaseDatePrefix):")
          .font(.title2)
        Text(stage.releaseDate)
          .font(.title2)
        Spacer()
          .frame(height: 20)
        Text("\(inkableAreaPrefix):")
        Text("\(stage.inkableArea)p")
      }
      .padding()
    }
  }
}

// MARK: - StageDetailView_Previews

struct StageDetailView_Previews: PreviewProvider {
  static var previews: some View {
    StageDetailView(stage: .anchoVGames)
  }
}
