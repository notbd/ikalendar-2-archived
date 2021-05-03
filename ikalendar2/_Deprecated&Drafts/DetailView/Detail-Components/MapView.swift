//
//  MapView.swift
//  ikalendar2
//
//  Created by Tianwei Zhang on 4/17/21.
//

import MapKit
import SwiftUI

// MARK: - MapView

/// A view that displays a geo information on the built-in map.
struct MapView: View {
  var latitude: Double
  var longitude: Double
  @State private var region = MKCoordinateRegion()

  var body: some View {
    Map(coordinateRegion: $region)
      .onAppear {
        setRegion()
      }
  }

  private func setRegion() {
    region =
      MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: latitude, longitude: longitude),
                         span: MKCoordinateSpan(latitudeDelta: 0.008, longitudeDelta: 0.008))
  }
}

// MARK: - MapView_Previews

struct MapView_Previews: PreviewProvider {
  static var previews: some View {
    MapView(latitude: 34.011_286, longitude: -116.166_868)
  }
}
