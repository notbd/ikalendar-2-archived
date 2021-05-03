//
//  View+Ext.swift
//  ikalendar2
//
//  Created by Tianwei Zhang on 4/11/21.
//

import SwiftUI

extension View {
  /// This function will apply transform to our view when condition is true,
  /// otherwise it will leave the original view untouched.
  ///
  /// ### Usage example: ###
  /// ```
  /// var body: some view {
  ///   myView
  ///     .if(X) { $0.padding(8) }
  ///     .if(Y) { $0.background(Color.blue) }
  /// }
  /// ```
  ///
  /// - Parameters:
  ///   - condition: The condition for the transform.
  ///   - transform: The transform function/modifier.
  /// - Returns: The resulted view.
  @ViewBuilder
  func `if`<Transform: View>(
    _ condition: Bool,
    transform: (Self) -> Transform)
  -> some View {
    if condition {
      transform(self)
    } else {
      self
    }
  }

  /// This function will apply a transform to our view when condition is true,
  /// and the another transform to the view otherwise.
  ///
  /// ### Usage example: ###
  /// ```
  /// var body: some view {
  ///   myView
  ///     .if(X) { $0.padding(8) } else: { $0.background(Color.blue) }
  /// }
  /// ```
  ///
  /// - Parameters:
  ///   - condition: The condition for the transform.
  ///   - ifTransform: The transform to apply if the condition is true.
  ///   - elseTransform: The condition to apply for the transform is false.
  /// - Returns: The resulted view.
  @ViewBuilder
  func `if`<TrueContent: View, FalseContent: View>(
    _ condition: Bool,
    if ifTransform: (Self) -> TrueContent,
    else elseTransform: (Self) -> FalseContent)
  -> some View {
    if condition {
      ifTransform(self)
    } else {
      elseTransform(self)
    }
  }

  /// This function will apply a transform to our view
  /// if the value is non-nil.
  ///
  /// ### Usage example: ###
  /// ```
  /// var body: some view {
  ///   myView
  ///     .ifLet(optionalColor) { $0.foregroundColor($1) }
  /// }
  /// ```
  ///
  /// - Parameters:
  ///   - value: The optional value to evaluate.
  ///   - transform: The transform function/modifier.
  /// - Returns: The resulted view.
  @ViewBuilder
  func ifLet<V, Transform: View>(
    _ value: V?,
    transform: (Self, V) -> Transform)
  -> some View {
    if let value = value {
      transform(self, value)
    } else {
      self
    }
  }
}
