//
//  CheckInResultAlertViewController.swift
//  EventsApp
//
//  Created by Luis Gustavo Avelino de Lima Jacinto on 21/12/20.
//

import UIKit

final class CheckInResultAlertViewController: UIViewController {

  // MARK: - Properties
  lazy var screen = CheckInResultAlertViewControllerScreen(frame: .zero)
  let blurEffectView = UIVisualEffectView(effect: UIBlurEffect(style: .dark))
  weak var coordinator: MainCoordinator?

  // MARK: - Init
  init(code: HTTPStatusCode?, networkError: NetworkError?) {
    super.init(nibName: nil, bundle: nil)
    setupView()
    setupScreen(code: code, networkError: networkError)
    addTargets()
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  // MARK: - Deinit
  deinit {
    removeTargets()
  }

  // MARK: - Methods
  func setupScreen(code: HTTPStatusCode?, networkError: NetworkError?) {
    if let _ = code {
      screen.titleLabel.text = "Successo"
      screen.descriptionLabel.text = "Check In realizado!"
    } else if let _ = networkError {
      screen.titleLabel.text = "Erro"
      screen.descriptionLabel.text = "Não foi possível realizar o Check In. Por favor, tente novamente."
    } else {
      preconditionFailure("The should exist a code or an error")
    }
  }

  @objc func closeButtonTapped() {
    print(#function)
    coordinator?.dismissAlerts()
  }

  func removeTargets() {
    screen.closeButton.removeTarget(self, action: nil, for: .touchUpInside)
  }

  func addTargets() {
    screen.closeButton.addTarget(self, action: #selector(closeButtonTapped), for: .touchUpInside)
  }

}

// MARK: - ViewCodable Extension
extension CheckInResultAlertViewController: ViewCodable {
  func buildViewHierarchy() {
    view.addSubview(screen)
    view.addSubview(blurEffectView)
  }

  func setupConstraints() {
    screen.snp.makeConstraints { make in
      make.center.equalToSuperview()
      make.height.equalToSuperview().multipliedBy(0.25)
      make.width.equalToSuperview().multipliedBy(0.8)
    }

    blurEffectView.snp.makeConstraints { make in
      make.top.bottom.right.left.equalToSuperview()
    }
  }

  func setupAdditionalConfiguration() {
    view.bringSubviewToFront(screen)
  }
}
