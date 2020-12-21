//
//  CheckInResultAlertViewControllerScreen.swift
//  EventsApp
//
//  Created by Luis Gustavo Avelino de Lima Jacinto on 21/12/20.
//

import UIKit

final class CheckInResultAlertViewControllerScreen: UIView {

  // MARK: - Properties
  let titleLabel = UILabel(frame: .zero)
  let descriptionLabel = UILabel(frame: .zero)
  let closeButton = UIButton(type: .system)
  fileprivate let padding = CGFloat(20)

  // MARK: - Inits
  override init(frame: CGRect) {
    super.init(frame: frame)
    setupView()
    setupTexts()
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  // MARK: - Init
  fileprivate func setupTexts() {

  }
}

// MARK: - ViewCodable Extension
extension CheckInResultAlertViewControllerScreen: ViewCodable {
  func buildViewHierarchy() {
    addSubview(titleLabel)
    addSubview(descriptionLabel)
    addSubview(closeButton)
  }

  func setupConstraints() {
    titleLabel.snp.makeConstraints { make in
      make.left.top.equalToSuperview().offset(padding)
      make.right.top.equalToSuperview().inset(padding)
      make.height.equalToSuperview().multipliedBy(0.1)
    }

    descriptionLabel.snp.makeConstraints { make in
      make.left.equalToSuperview().offset(padding)
      make.right.equalToSuperview().inset(padding)
      make.top.equalTo(titleLabel.snp.bottom).offset(padding)
      make.bottom.equalTo(closeButton.snp.top)
    }

    closeButton.snp.makeConstraints { make in
      make.bottom.equalToSuperview().inset(padding)
      make.left.equalToSuperview().offset(padding)
      make.right.equalToSuperview().inset(padding)
      make.height.equalToSuperview().multipliedBy(0.1)
    }
  }

  func setupAdditionalConfiguration() {
    titleLabel.textAlignment = .center
    titleLabel.font = .systemFont(ofSize: 24, weight: .bold)

    descriptionLabel.textAlignment = .center
    descriptionLabel.numberOfLines = 5

    closeButton.setTitle("Close", for: .normal)
    closeButton.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: .bold)

    backgroundColor = .white
  }
}
