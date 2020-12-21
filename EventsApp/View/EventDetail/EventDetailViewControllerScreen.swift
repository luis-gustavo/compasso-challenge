//
//  EventDetailViewControllerScreen.swift
//  EventsApp
//
//  Created by Luis Gustavo Avelino de Lima Jacinto on 20/12/20.
//

import UIKit

final class EventDetailViewControllerScreen: UIView {

  // MARK: - Properties
  let eventImage = EventImage(frame: .zero)
  let eventDescription = UILabel(frame: .zero)
  let checkinButton = UIButton(type: .system)
  fileprivate let padding = CGFloat(20)

  // MARK: - Inits
  override init(frame: CGRect) {
    super.init(frame: CGRect(origin: .zero, size: CGSize(width: 200, height: 200)))
    setupView()
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

}

// MARK: - ViewCodable Extension
extension EventDetailViewControllerScreen: ViewCodable {
  func buildViewHierarchy() {
    addSubview(eventImage)
    addSubview(eventDescription)
    addSubview(checkinButton)
  }

  func setupConstraints() {

    eventImage.snp.makeConstraints { make in
      make.top.left.equalTo(self.safeAreaInsets.bottom).offset(padding)
      make.right.equalToSuperview().inset(padding)
      make.height.equalToSuperview().multipliedBy(0.4)
    }

    checkinButton.snp.makeConstraints { make in
      make.left.equalToSuperview().offset(padding)
      make.right.bottom.equalToSuperview().inset(padding)
      make.height.equalToSuperview().multipliedBy(0.1)
    }

    eventDescription.snp.makeConstraints { make in
      make.left.equalToSuperview().offset(padding)
      make.right.equalToSuperview().inset(padding)
      make.bottom.equalTo(checkinButton.snp.top).inset(padding)
      make.top.equalTo(eventImage.snp.bottom).offset(padding)
    }
  }

  func setupAdditionalConfiguration() {
    checkinButton.setTitle("Check In", for: .normal)
    checkinButton.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: .bold)
    eventDescription.numberOfLines = 10
    eventDescription.sizeToFit()
    eventImage.state = .idle
    backgroundColor = .white
  }
}
