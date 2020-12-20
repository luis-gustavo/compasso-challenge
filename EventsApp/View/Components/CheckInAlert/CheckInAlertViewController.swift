//
//  CheckInAlertViewController.swift
//  EventsApp
//
//  Created by Luis Gustavo Avelino de Lima Jacinto on 20/12/20.
//

import UIKit

protocol CheckInAlertViewDelegate {
  func cancelButtonClicked(_ sender: CheckInAlertViewController)
  func confirmButtonClicked(_ sender: CheckInAlertViewController, with name: String, andEmail email: String)
}

final class CheckInAlertViewController: UIViewController {

  // MARK: - Properties
  lazy var screen = CheckInAlertViewControllerScreen(frame: .zero)
  var delegate: CheckInAlertViewDelegate?

  // MARK: - Inits
  init() {
    super.init(nibName: nil, bundle: nil)

    setupView()

    screen.cancelButton.addTarget(self, action: #selector(cancelButtonClicked), for: .touchUpInside)
    screen.confirmButton.addTarget(self, action: #selector(confirmButtonClicked), for: .touchUpInside)
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  // MARK: - Deinit
  deinit {
    screen.cancelButton.removeTarget(screen.cancelButton, action: nil, for: .touchUpInside)
    screen.confirmButton.removeTarget(screen.confirmButton, action: nil, for: .touchUpInside)
  }

  // MARK: - Methods
  @objc private func cancelButtonClicked() {
    delegate?.cancelButtonClicked(self)
  }

  @objc private func confirmButtonClicked() {
    delegate?.confirmButtonClicked(self, with: screen.nameTextField.text ?? "", andEmail: screen.emailTextField.text ?? "")
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

  func setupAdditionalConfiguration() {

  }
}
