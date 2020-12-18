//
//  ViewCodable.swift
//  EventsApp
//
//  Created by Luis Gustavo Avelino de Lima Jacinto on 18/12/20.
//

import Foundation

protocol ViewCodable {
  func buildViewHierarchy()
  func setupConstraints()
  func setupAdditionalConfiguration()
  func setupView()
}

extension ViewCodable {
  func setupView() {
    buildViewHierarchy()
    setupConstraints()
    setupAdditionalConfiguration()
  }
}
