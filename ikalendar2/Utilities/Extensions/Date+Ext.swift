//
//  Date+Ext.swift
//  ikalendar2
//
//  Created by Tianwei Zhang on 4/9/21.
//

import Foundation

extension Date {
  /// Get the TimeInterval between two Dates.
  /// - Parameters:
  ///   - lhs: The date to be subtracted from.
  ///   - rhs: The date to subtracted.
  /// - Returns: The difference of the two Dates in TimeInterval format.
  static func - (
    lhs: Date,
    rhs: Date)
  -> TimeInterval {
    lhs.timeIntervalSinceReferenceDate - rhs.timeIntervalSinceReferenceDate
  }
}

extension Date {
  /// Strip the minutes and below components of the Date.
  /// - Returns: The stripped Date.
  func removeMinutes() -> Date? {
    let components = Calendar.current.dateComponents([.year, .month, .day, .hour], from: self)
    return Calendar.current.date(from: components)
  }
}

extension Date {
  private static let ikaTimeFormatter = DateFormatter(ikaType: .time)
  private static let ikaDateFormatter = DateFormatter(ikaType: .date)

  // MARK: Internal

  /// Convert the Date to a battle time string.
  /// - Parameters:
  ///   - includingDate: If including the date in the time string (default to false).
  ///   - currentTime: Placeholder to let SwiftUI recalculate the string every time this
  ///   parameter has changed.
  /// - Returns: The battle time string.
  func toBattleTimeString(
    includingDate: Bool = false,
    currentTime _: Date = Date())
  -> String {
    let timeString = Date.ikaTimeFormatter.string(from: self)

    guard includingDate
    else { return timeString }

    guard !Calendar.current.isDateInToday(self)
    else { return String.localizedString(for: "Today") + " " + timeString }

    guard !Calendar.current.isDateInYesterday(self)
    else { return String.localizedString(for: "Yesterday") + " " + timeString }

    guard !Calendar.current.isDateInTomorrow(self)
    else { return String.localizedString(for: "Tomorrow") + " " + timeString }

    // default: only time
    return timeString
  }

  /// Convert the Date to a salmon time string.
  /// - Parameters:
  ///   - includingDate: If including the date in the time string (default to false).
  ///   - currentTime: Placeholder to let SwiftUI recalculate the string every time this
  ///   parameter has changed.
  /// - Returns: The salmon time string.
  func toSalmonTimeString(
    includingDate: Bool = false,
    currentTime _: Date = Date())
  -> String {
    let timeString = Date.ikaTimeFormatter.string(from: self)

    guard includingDate
    else { return timeString }

    guard !Calendar.current.isDateInToday(self)
    else { return String.localizedString(for: "Today") + " " + timeString }

    guard !Calendar.current.isDateInYesterday(self)
    else { return String.localizedString(for: "Yesterday") + " " + timeString }

    guard !Calendar.current.isDateInTomorrow(self)
    else { return String.localizedString(for: "Tomorrow") + " " + timeString }

    // default: date + time
    let dateString = Date.ikaDateFormatter.string(from: self)
    return dateString + timeString
  }

  /// Convert the Date to a time remaining string.
  /// - Parameter deadline: The deadline to compute the remaining time from.
  /// - Returns: The remaining time string.
  func toTimeRemainingString(until deadline: Date) -> String {
    let remainingTime = Int(deadline - self)
    // if time has already passed
    if remainingTime < 0 { return String.localizedString(for: "Finished") }
    // convert time interval to TimeLength
    let days = remainingTime / (24 * 60 * 60)
    let hours = (remainingTime / (60 * 60)) % 24
    let minutes = (remainingTime / 60) % 60
    let seconds = remainingTime % 60
    let timeLength = TimeLength(days: days, hours: hours, minutes: minutes, seconds: seconds)
    let timeLengthString = timeLength.getLocalizedStringDescription()
    return String(format: NSLocalizedString("remaining %@", comment: ""),
                  timeLengthString)
  }
}
