//
//  CheckInAlertView.swift
//  EventsApp
//
//  Created by Luis Gustavo Avelino de Lima Jacinto on 20/12/20.
//

import UIKit

final class CheckInAlertView: UIViewController {

  // MARK: - Properties
  let titleLabel = UILabel(frame: .zero)
  let descriptionLabel = UILabel(frame: .zero)
  let nameTextField = UITextField(frame: .zero)
  let emailTextField = UITextField(frame: .zero)
  let cancelButton = UIButton(frame: .zero)
  let confirmButton = UIButton(frame: .zero)

  // MARK: - Inits
  init() {
    super.init(nibName: nil, bundle: nil)
    setupView()
    nameTextField.becomeFirstResponder()
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}

// MARK: - ViewCodable Extension
extension CheckInAlertView: ViewCodable {
  func buildViewHierarchy() {
    view.addSubview(titleLabel)
    view.addSubview(descriptionLabel)
    view.addSubview(nameTextField)
    view.addSubview(emailTextField)
    view.addSubview(cancelButton)
    view.addSubview(confirmButton)
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
      make.right.top.equalToSuperview().inset(10)
      make.top.equalTo(descriptionLabel.snp.bottom).offset(20)
      make.height.equalToSuperview().multipliedBy(0.1)
    }

    nameTextField.snp.makeConstraints { make in
      make.left.equalToSuperview().offset(10)
      make.right.top.equalToSuperview().inset(10)
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

    descriptionLabel.text = "Type your information to make check in the event"

    nameTextField.placeholder = "Name"

    emailTextField.placeholder = "Email"
    emailTextField.keyboardType = .emailAddress

    cancelButton.setTitle("Cancel", for: .normal)
    cancelButton.tintColor = .red

    confirmButton.setTitle("Confirm", for: .normal)
    confirmButton.tintColor = .blue
  }
}

