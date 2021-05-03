//
//  SalmonRotationWeaponCard.swift
//  ikalendar2
//
//  Created by Tianwei Zhang on 4/4/21.
//

import SwiftUI

// MARK: - SalmonRotationWeaponCardPrimary

/// The primary version of a card component that displays
/// the weapon information of a salmon rotation.
struct SalmonRotationWeaponCardPrimary: View {
  typealias Scoped = Constants.Styles.Rotation.Salmon.Card.Weapon.Primary

  var weapon: SalmonWeapon
  var width: CGFloat

  var body: some View {
    VStack(alignment: .center) {
      Image(weapon.imgFiln)
        .resizable()
        .scaledToFit()
        .cornerRadius(Scoped.IMG_CORNER_RADIUS)
        .shadow(radius: Constants.Styles.Global.SHADOW_RADIUS)
        .padding(Scoped.IMG_PADDING)
        .silhouetteFrame(cornerRadius: Scoped.SILHOUETTE_CORNER_RADIUS)

      Text(weapon.name)
        .scaledLimitedLine()
        .fontIka(.ika2, size: Scoped.FONT_SIZE)
        .frame(height: width * Scoped.TEXT_FRAME_HEIGHT_RATIO)
    }
    .frame(width: width)
  }
}

// MARK: - SalmonRotationWeaponCardSecondary

/// The secondary version of a card component that displays
/// the weapon information of a salmon rotation.
struct SalmonRotationWeaponCardSecondary: View {
  typealias Scoped = Constants.Styles.Rotation.Salmon.Card.Weapon.Secondary

  var weapons: [SalmonWeapon]!

  let columns: [GridItem] = [
    GridItem(.flexible()),
    GridItem(.flexible()),
  ]

  var body: some View {
    LazyVGrid(columns: columns) {
      ForEach(Array(weapons.enumerated()), id: \.offset) { _, weapon in
        // enumerate the array identify weapons even with same id (e.g. 4 randoms)
        SalmonRotationWeaponCardSecondaryIcon(weapon: weapon)
      }
    }
  }
}

// MARK: - SalmonRotationWeaponCardSecondaryIcon

struct SalmonRotationWeaponCardSecondaryIcon: View {
  typealias Scoped = Constants.Styles.Rotation.Salmon.Card.Weapon.Secondary
  var weapon: SalmonWeapon
  var body: some View {
    Image(weapon.imgFiln)
      .resizable()
      .scaledToFit()
      .shadow(radius: Constants.Styles.Global.SHADOW_RADIUS)
      .padding(Scoped.IMG_PADDING)
      .silhouetteFrame(cornerRadius: Scoped.SILHOUETTE_CORNER_RADIUS)
  }
}

// struct SalmonRotationWeaponCard_Previews: PreviewProvider {
//  static var previews: some View {
//    SalmonRotationWeaponCard()
//  }
// }
