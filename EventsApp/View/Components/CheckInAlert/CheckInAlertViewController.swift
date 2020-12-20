//
//  CheckInAlertViewController.swift
//  EventsApp
//
//  Created by Luis Gustavo Avelino de Lima Jacinto on 20/12/20.
//

import UIKit

protocol CheckInAlertViewDelegate {
  func cancelButtonClicked(_ sender: CheckInAlertViewController)
  func confirmButtonClicked(_ sender: CheckInAlertViewController)
  func textFieldEditingChanged(name: UITextField, email: UITextField)
}

final class CheckInAlertViewController: UIViewController {

  // MARK: - Properties
  lazy var screen = CheckInAlertViewControllerScreen(frame: .zero)
  var delegate: CheckInAlertViewDelegate?

  // MARK: - Inits
  init() {
    super.init(nibName: nil, bundle: nil)
    setupView()
    setup()
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  // MARK: - Deinit
  deinit {
    removeTargets()
  }

  // MARK: - Methods
  func setup() {
    addTargets()
    setupDelegates()
  }

  @objc private func cancelButtonClicked() {
    delegate?.cancelButtonClicked(self)
  }

  @objc private func confirmButtonClicked() {
    delegate?.confirmButtonClicked(self)
  }

  @objc func nameEditingChanged(textField: UITextField) {
    delegate?.textFieldEditingChanged(name: screen.nameTextField, email: screen.emailTextField)
  }

  @objc func emailEditingChanged(textField: UITextField) {
    delegate?.textFieldEditingChanged(name: screen.nameTextField, email: screen.emailTextField)
  }
}

// MARK: - Setup Methods Extension
extension CheckInAlertViewController {
  fileprivate func addTargets() {
    screen.cancelButton.addTarget(self, action: #selector(cancelButtonClicked), for: .touchUpInside)
    screen.confirmButton.addTarget(self, action: #selector(confirmButtonClicked), for: .touchUpInside)
    screen.nameTextField.addTarget(self, action: #selector(nameEditingChanged), for: .editingChanged)
    screen.emailTextField.addTarget(self, action: #selector(emailEditingChanged), for: .editingChanged)
    hideKeyboardWhenTappedAround()
  }

  fileprivate func removeTargets() {
    screen.cancelButton.removeTarget(screen.cancelButton, action: nil, for: .touchUpInside)
    screen.confirmButton.removeTarget(screen.confirmButton, action: nil, for: .touchUpInside)
    screen.nameTextField.removeTarget(self, action: nil, for: .editingChanged)
    screen.emailTextField.removeTarget(self, action: nil, for: .editingChanged)
  }

  fileprivate func setupDelegates() {
    screen.emailTextField.delegate = self
    screen.nameTextField.delegate = self
  }
}

// MARK: - ViewCodable Extension
extension CheckInAlertViewController: ViewCodable {
  func buildViewHierarchy() {
    view.addSubview(screen)
  }

  func setupConstraints() {
    screen.snp.makeConstraints { make in
      make.height.equalToSuperview().multipliedBy(0.5)
      make.width.equalToSuperview().multipliedBy(0.8)
      make.centerX.equalToSuperview()
      make.centerY.equalToSuperview()
    }
  }

  func setupAdditionalConfiguration() { }
}

// MARK: - UITextFieldDelegate Extension
extension CheckInAlertViewController: UITextFieldDelegate {
  func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    if textField == screen.nameTextField {
      screen.emailTextField.becomeFirstResponder()
    } else {
      textField.resignFirstResponder()
    }
    return true
  }
}
