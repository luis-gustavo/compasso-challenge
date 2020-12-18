//
//  EventsViewControllerScreen.swift
//  EventsApp
//
//  Created by Luis Gustavo Avelino de Lima Jacinto on 18/12/20.
//

import UIKit

final class EventsViewControllerScreen: UIView {

  // MARK: - Inits
  override init(frame: CGRect) {
    super.init(frame: frame)
    setupView()
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

}

extension EventsViewControllerScreen: ViewCodable {
  func buildViewHierarchy() {

  }

  func setupConstraints() {

  }

  func setupAdditionalConfiguration() {
    backgroundColor = .green
  }
}
