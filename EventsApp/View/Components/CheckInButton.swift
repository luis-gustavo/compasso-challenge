//
//  CheckInButton.swift
//  EventsApp
//
//  Created by Luis Gustavo Avelino de Lima Jacinto on 20/12/20.
//

import UIKit

protocol CheckInButtonDelegate {
  func buttonClicked(_ sender: CheckInButton)
}

final class CheckInButton: UIButton {

  // MARK: - Properties
  var delegate: CheckInButtonDelegate?

  // MARK: - Inits
  override init(frame: CGRect) {
    super.init(frame: frame)

    setupView()
    addTarget(self, action: #selector(buttonClicked), for: .touchUpInside)
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  // MARK: - Deinit
  deinit {
    removeTarget(self, action: nil, for: .touchUpInside)
  }

  // MARK: - Methods
  @objc private func buttonClicked() {
    delegate?.buttonClicked(self)
  }

  private func applyGradient(colors: [CGColor]) {
    let gradientLayer = CAGradientLayer()
    gradientLayer.colors = colors
    gradientLayer.startPoint = CGPoint(x: 0, y: 0)
    gradientLayer.endPoint = CGPoint(x: 1, y: 0)
    gradientLayer.frame = self.bounds
    self.layer.insertSublayer(gradientLayer, at: 0)
  }
}

// MARK: - ViewCodable Extension
extension CheckInButton: ViewCodable {
  func buildViewHierarchy() { }

  func setupConstraints() { }

  func setupAdditionalConfiguration() {
    applyGradient(colors: [UIColor.systemRed.cgColor, UIColor.systemGreen.cgColor])
  }
}
