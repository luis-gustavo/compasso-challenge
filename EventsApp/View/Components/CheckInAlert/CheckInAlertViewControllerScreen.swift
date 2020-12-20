//
//  CheckInAlertViewControllerScreen.swift
//  EventsApp
//
//  Created by Luis Gustavo Avelino de Lima Jacinto on 20/12/20.
//

import UIKit

final class CheckInAlertViewControllerScreen: UIView {

  // MARK: - Properties
  let titleLabel = UILabel(frame: .zero)
  let descriptionLabel = UILabel(frame: .zero)
  let nameTextField = UITextField(frame: .zero)
  let emailTextField = UITextField(frame: .zero)
  let cancelButton = UIButton(type: .close)
  let confirmButton = UIButton(type: .system)
  var delegate: CheckInAlertViewDelegate?

  // MARK: - Inits
  override init(frame: CGRect) {
    super.init(frame: frame)
    setupView()
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}

// MARK: - ViewCodable Extension
extension CheckInAlertViewControllerScreen: ViewCodable {
  func buildViewHierarchy() {
    addSubview(titleLabel)
    addSubview(descriptionLabel)
    addSubview(nameTextField)
    addSubview(emailTextField)
    addSubview(cancelButton)
    addSubview(confirmButton)
  }

  func setupConstraints() {
    titleLabel.snp.makeConstraints { make in
      make.left.top.equalToSuperview().offset(10)
      make.right.top.equalToSuperview().inset(10)
      make.height.equalToSuperview().multipliedBy(0.1)
    }

    descriptionLabel.snp.makeConstraints { make in
      make.left.equalToSuperview().offset(10)
      make.right.equalToSuperview().inset(10)
      make.top.equalTo(titleLabel.snp.bottom).offset(10)
      make.height.equalToSuperview().multipliedBy(0.2)
    }

    nameTextField.snp.makeConstraints { make in
      make.left.equalToSuperview().offset(10)
      make.right.equalToSuperview().inset(10)
      make.top.equalTo(descriptionLabel.snp.bottom).offset(20)
      make.height.equalToSuperview().multipliedBy(0.1)
    }

    emailTextField.snp.makeConstraints { make in
      make.left.equalToSuperview().offset(10)
      make.right.equalToSuperview().inset(10)
      make.top.equalTo(nameTextField.snp.bottom).offset(10)
      make.height.equalToSuperview().multipliedBy(0.1)
    }

    cancelButton.snp.makeConstraints { make in
      make.bottom.equalToSuperview().inset(10)
      make.left.equalToSuperview().offset(10)
      make.height.equalToSuperview().multipliedBy(0.1)
    }

    confirmButton.snp.makeConstraints { make in
      make.bottom.equalToSuperview().inset(10)
      make.right.equalToSuperview().inset(10)
      make.height.equalToSuperview().multipliedBy(0.1)
    }
  }

  func setupAdditionalConfiguration() {
    titleLabel.text = "Check In"
    titleLabel.textAlignment = .center
    titleLabel.font = .systemFont(ofSize: 24, weight: .bold)

    descriptionLabel.text = "Type your information to make check in the event"
    descriptionLabel.textAlignment = .center
    descriptionLabel.numberOfLines = 5

    nameTextField.placeholder = "Name"

    emailTextField.placeholder = "Email"
    emailTextField.keyboardType = .emailAddress

    cancelButton.setTitle("Cancel", for: .normal)

    confirmButton.setTitle("Confirm", for: .normal)

    backgroundColor = UIColor.systemGray
  }
}
