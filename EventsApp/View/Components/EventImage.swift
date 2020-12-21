//
//  EventImage.swift
//  EventsApp
//
//  Created by Luis Gustavo Avelino de Lima Jacinto on 21/12/20.
//

import UIKit

final class EventImage: UIImageView {

  enum EventImageState {
    case idle
    case fetching
    case fetched(success: Bool)
  }

  // MARK: - Properties
  fileprivate var activityIndicator = UIActivityIndicatorView(frame: .zero)
  var state: EventImageState = .idle {
    didSet {
      change(to: state)
    }
  }
  var errorImage: UIImage {
    guard let errorImage = UIImage(named: "errorImage") else {
      preconditionFailure("The error image must exist")
    }

    return errorImage
  }

  // MARK: - Init
  override init(frame: CGRect) {
    super.init(frame: frame)
    setupView()
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  // MARK: - Methods
  func showActivityIndicator() {
    activityIndicator.isHidden = false
    activityIndicator.startAnimating()
  }

  func hideActivityIndicator() {
    activityIndicator.isHidden = true
    activityIndicator.stopAnimating()
  }

  fileprivate func change(to state: EventImageState) {
    switch state {
    case .idle:
      hideActivityIndicator()
    case .fetching:
      showActivityIndicator()
    case let .fetched(success):
      hideActivityIndicator()
      if (!success) {
        image = errorImage
      }
    }
  }
}

// MARK: - ViewCodable Extension
extension EventImage: ViewCodable {
  func buildViewHierarchy() {
    addSubview(activityIndicator)
  }

  func setupConstraints() {
    activityIndicator.snp.makeConstraints { make in
      make.height.width.equalToSuperview()
      make.center.equalToSuperview()
    }
  }

  func setupAdditionalConfiguration() {
    activityIndicator.color = .white
  }
}

