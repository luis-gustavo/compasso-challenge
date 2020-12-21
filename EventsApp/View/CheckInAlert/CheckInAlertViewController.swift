//
//  CheckInAlertViewController.swift
//  EventsApp
//
//  Created by Luis Gustavo Avelino de Lima Jacinto on 20/12/20.
//

import UIKit

final class CheckInAlertViewController: UIViewController {

  // MARK: - Properties
  let blurEffectView = UIVisualEffectView(effect: UIBlurEffect(style: .dark))
  let viewModel: CheckInViewModel
  weak var coordinator: MainCoordinator?
  lazy var screen = CheckInAlertViewControllerScreen(frame: .zero)

  // MARK: - Inits
  init(eventId: String) {
    self.viewModel = CheckInViewModel(eventId: eventId)
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
    setupTextFieldDelegates()
    setupViewModelDelegate()
    hideKeyboardWhenTappedAround()
  }

  @objc private func cancelButtonClicked() {
    coordinator?.dismissAlerts()
  }

  @objc private func confirmButtonClicked() {
    viewModel.makeCheckIn()
  }

  @objc func textFieldEditingChanged() {
    viewModel.validateForm(name: screen.nameTextField.text ?? "", email: screen.emailTextField.text ?? "")
  }

  @objc func keyboardWillShow() {
    view.frame.origin.y = -150
  }

  @objc func keyboardWillHide() {
    view.frame.origin.y = 0
  }

}

// MARK: - Setup Methods Extension
extension CheckInAlertViewController {
  fileprivate func addTargets() {
    screen.cancelButton.addTarget(self, action: #selector(cancelButtonClicked), for: .touchUpInside)
    screen.confirmButton.addTarget(self, action: #selector(confirmButtonClicked), for: .touchUpInside)
    screen.nameTextField.addTarget(self, action: #selector(textFieldEditingChanged), for: .editingChanged)
    screen.emailTextField.addTarget(self, action: #selector(textFieldEditingChanged), for: .editingChanged)
    NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
    NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
  }

  fileprivate func removeTargets() {
    screen.cancelButton.removeTarget(screen.cancelButton, action: nil, for: .touchUpInside)
    screen.confirmButton.removeTarget(screen.confirmButton, action: nil, for: .touchUpInside)
    screen.nameTextField.removeTarget(self, action: nil, for: .editingChanged)
    screen.emailTextField.removeTarget(self, action: nil, for: .editingChanged)
    NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
    NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
  }

  fileprivate func setupTextFieldDelegates() {
    screen.emailTextField.delegate = self
    screen.nameTextField.delegate = self
  }

  fileprivate func setupViewModelDelegate() {
    viewModel.delegate = self
  }
}

// MARK: - ViewCodable Extension
extension CheckInAlertViewController: ViewCodable {
  func buildViewHierarchy() {
    view.addSubview(screen)
    view.addSubview(blurEffectView)
  }

  func setupConstraints() {
    screen.snp.makeConstraints { make in
      make.height.equalToSuperview().multipliedBy(0.5)
      make.width.equalToSuperview().multipliedBy(0.8)
      make.centerX.equalToSuperview()
      make.centerY.equalToSuperview()
    }

    blurEffectView.snp.makeConstraints { make in
      make.top.bottom.right.left.equalToSuperview()
    }
  }

  func setupAdditionalConfiguration() {
    view.bringSubviewToFront(screen)
  }
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

// MARK: - CheckInViewModelDelegate Extension
extension CheckInAlertViewController: CheckInViewModelDelegate {
  func confirmButtonStateChanged(_ enable: Bool) {
    screen.confirmButton.isEnabled = enable
  }
}
