//
//  StyleConstants.swift
//  ikalendar2
//
//  Created by Tianwei Zhang on 3/27/21.
//

import SwiftUI

/// Constant data holding `style parameters` for the app.
extension Constants.Styles {
  enum Global {
    static let SHADOW_RADIUS: CGFloat = 6
    static let MIN_TEXT_SCALE_FACTOR: CGFloat = 0.3
    static let ANIMATION_DURATION: Double = 0.2
  }

  enum Frame {
    static let MIN_TAPPABLE_AREA_SIDE: CGFloat = 44
    static let SILHOUETTE_BACKGROUND_COLOR = Color(UIColor.systemGray2)
  }

  enum Overlay {
    enum Loading {
      static let SILHOUETTE_CORNER_RADIUS: CGFloat = 5
    }

    enum AutoLoading {
      static let SFSYMBOL_FONT: Font = .system(size: 20, weight: .medium)
      static let SILHOUETTE_SIDE: CGFloat = 36
      static let SILHOUETTE_CORNER_RADIUS: CGFloat = 5

      static let LOADING_SFSYMBOL: String = "icloud.and.arrow.down.fill"
      static let LOADED_SUCCESS_SFSYMBOL: String = "checkmark.icloud.fill"
      static let LOADED_FAILURE_SFSYMBOL: String = "exclamationmark.icloud.fill"
      static let REGULAR_SFSYMBOL: String = "icloud.fill"
    }
  }

  enum ToolbarButton {
    static let SFSYMBOL_FONT: Font = .system(size: 20, weight: .medium)
    static let IMG_SIDE: CGFloat = 28

    static let SILHOUETTE_SIDE: CGFloat = 36
    static let SILHOUETTE_CORNER_RADIUS: CGFloat = 5

    static let GAME_MODE_SWITCH_SFSYMBOL: String = "rectangle.fill.on.rectangle.angled.fill"
  }

  enum Error {
    static let CONTENT_WIDTH_RATIO: CGFloat = 0.8

    static let USES_CUSTOM_FONT: Bool = true
    static let TITLE_CUSTOM_FONT_SIZE: CGFloat = 31
    static let MESSAGE_CUSTOM_FONT_SIZE: CGFloat = 16
  }

  enum Rotation {
    enum Label {
      static let BACKGROUND_CORNER_RADIUS: CGFloat = 5
      static let TEXT_PADDING_HORIZONTAL: CGFloat = 6
      static let TEXT_OFFSET_Y: CGFloat = -0.5
    }

    // MARK: - SALMON RUN

    enum Salmon {
      enum Header {
        static let FIRST_PREFIX_STRINGS = (busy: "Open!", idle: "Next:")
        static let SECOND_PREFIX_STRING = "Soon:"

        static let SPACING: CGFloat = 16

        static let PREFIX_SILHOUETTE_CORNER_RADIUS: CGFloat = 8
        static let FONT_SIZE: CGFloat = 15
        static let PREFIX_PADDING: CGFloat = 8
      }

      enum Cell {
        enum Shared {
          enum TimeTextSection {
            static let SALMON_ICON_WIDTH_RATIO: CGFloat = 0.08
            static let TIME_TEXT_SPACING: CGFloat = 4
            static let TIME_TEXT_FONT_SIZE: CGFloat = 20
            static let TIME_TEXT_SINGLE_PADDING_HORIZONTAL: CGFloat = 5
            static let TIME_TEXT_SILHOUETTE_CORNER_RADIUS: CGFloat = 6
            static let TIME_TEXT_SECTION_PADDING: CGFloat = 4
          }
        }

        enum Primary {
          // body
          static let CELL_SPACING: CGFloat = 8
          static let STAGE_PROGRESS_SECTION_PADDING: CGFloat = 4
          static let CELL_PADDING: CGFloat = 3

          // stage and progress section
          static let STAGE_PROGRESS_SECTION_SPACING: CGFloat = 6
          static let LABEL_FONT_SIZE: CGFloat = 16
          static let PROGRESS_FONT_SIZE: CGFloat = 15

          // weapon section
          static let WEAPON_SINGLE_WIDTH_RATIO: CGFloat = 0.18
        }

        enum Secondary {
          static let STAGE_HEIGHT_RATIO: CGFloat = 0.36
          static let STAGE_HEIGHT_ADJUSTMENT_CONSTANT: CGFloat = -25
          static let CELL_SPACING: CGFloat = 5
          static let CELL_PADDING_VERTICAL: CGFloat = 0
          static let CELL_PADDING_BOTTOM: CGFloat = 9

          static let LABEL_FONT_SIZE: CGFloat = 12

          static let PROGRESS_FONT_SIZE: CGFloat = 15
        }

        enum Tertiary {
          static let CELL_SPACING: CGFloat = 5
          static let CELL_PADDING: CGFloat = 0
        }
      }

      enum Card {
        enum Stage {
          static let STAGE_IMG_CORNER_RADIUS: CGFloat = 4

          static let GEAR_SECTION_WIDTH_RATIO: CGFloat = 0.2
          static let LABEL_FONT_SIZE: CGFloat = 16
          static let OVERLAY_PADDING: CGFloat = 4

          static let GEAR_IMG_PADDING: CGFloat = 2
          static let GEAR_IMG_WIDTH_RATIO: CGFloat = 0.15
          static let GEAR_SILHOUETTE_CORNER_RADIUS: CGFloat = 5
        }

        enum Weapon {
          enum Primary {
            static let IMG_CORNER_RADIUS: CGFloat = 4
            static let IMG_PADDING: CGFloat = 4
            static let SILHOUETTE_CORNER_RADIUS: CGFloat = 5
            static let FONT_SIZE: CGFloat = 13
            static let TEXT_FRAME_HEIGHT_RATIO: CGFloat = 0.2
          }

          enum Secondary {
            static let IMG_PADDING: CGFloat = 3
            static let SILHOUETTE_CORNER_RADIUS: CGFloat = 5
          }
        }
      }
    }

    // MARK: - BATTLE

    enum Battle {
      enum Header {
        static let CURRENT_PREFIX_STRING = "Now:"
        static let NEXT_PREFIX_STRING = "Next:"

        static let SPACING: CGFloat = 16

        static let PREFIX_SILHOUETTE_CORNER_RADIUS: CGFloat = 8
        static let PREFIX_FONT_SIZE: CGFloat = 16
        static let PREFIX_PADDING: CGFloat = 8

        static let CONTENT_FONT_SIZE: CGFloat = 14
      }

      enum Cell {
        enum Primary {
          static let STAGE_SECTION_SPACING_RATIO: CGFloat = 0.04
          static let CELL_PADDING_TOP: CGFloat = 2
          static let CELL_PADDING_BOTTOM: CGFloat = 12

          static let RULE_SECTION_SPACING: CGFloat = 10
          static let RULE_IMG_MAX_WIDTH_RATIO: CGFloat = 0.09
          static let RULE_FONT_SIZE_COMPACT: CGFloat = 28
          static let RULE_FONT_SIZE_REGULAR: CGFloat = 48
          static let RULE_SECTION_HEIGHT_RATIO: CGFloat = 0.12

          static let REMAINING_TIME_FONT_RATIO: CGFloat = 0.038
          static let REMAINING_TIME_TEXT_MAX_WIDTH_RATIO: CGFloat = 0.34
          static let REMAINING_TIME_SECTION_WIDTH_RATIO: CGFloat = 0.35
        }

        enum Secondary {
          static let RULE_SECTION_SPACING: CGFloat = 2

          static let RULE_IMG_MAX_WIDTH: CGFloat = 0.1
          static let RULE_IMG_PADDING: CGFloat = 5
          static let RULE_IMG_SILHOUETTE_CORNER_RADIUS: CGFloat = 12

          static let RULE_FONT_SIZE: CGFloat = 18
          static let RULE_TITLE_HEIGHT: CGFloat = 24

          static let RULE_SECTION_WIDTH_RATIO: CGFloat = 0.16
          static let RULE_SECTION_PADDING_TRAILING: CGFloat = 10

          static let STAGE_SECTION_SPACING_RATIO: CGFloat = 0.04
          static let STAGE_SECTION_SPACING_ADJUSTMENT_CONSTANT: CGFloat = -6
        }
      }

      enum Card {
        enum Primary {
          static let IMG_CORNER_RADIUS: CGFloat = 4
          static let LABEL_FONT_SIZE: CGFloat = 12
          static let LABEL_PADDING_LEADING: CGFloat = 20
          static let LABEL_PADDING_BOTTOMTRAILING: CGFloat = 2
        }

        enum Secondary {
          static let IMG_CORNER_RADIUS: CGFloat = 4
          static let STAGE_IMG_OFFSET_Y: CGFloat = 6
          static let FONT_SIZE: CGFloat = 11
        }
      }
    }
  }
}
