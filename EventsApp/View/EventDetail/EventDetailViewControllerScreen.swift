//
//  EventDetailViewControllerScreen.swift
//  EventsApp
//
//  Created by Luis Gustavo Avelino de Lima Jacinto on 20/12/20.
//

import UIKit

final class EventDetailViewControllerScreen: UIView {

  // MARK: - Properties
  let eventImage = UIImageView(frame: .zero)
  let eventDescription = UILabel(frame: .zero)
  let checkinButton = UIButton(frame: .zero)

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
extension EventDetailViewControllerScreen: ViewCodable {
  func buildViewHierarchy() {
    addSubview(eventImage)
    addSubview(eventDescription)
    addSubview(checkinButton)
  }

  func setupConstraints() {

    eventImage.snp.makeConstraints { make in
      make.top.left.equalTo(self.safeAreaInsets.bottom).offset(20)
      make.right.equalToSuperview().inset(20)
      make.height.equalToSuperview().multipliedBy(0.4)
    }

    checkinButton.snp.makeConstraints { make in
      make.left.equalToSuperview().offset(20)
      make.right.bottom.equalToSuperview().inset(20)
      make.height.equalToSuperview().multipliedBy(0.1)
    }

    eventDescription.snp.makeConstraints { make in
      make.left.equalToSuperview().offset(20)
      make.right.equalToSuperview().inset(20)
      make.bottom.equalTo(checkinButton.snp.top).inset(20)
      make.top.equalTo(eventImage.snp.bottom).offset(20)
    }
  }

  func setupAdditionalConfiguration() {
    checkinButton.setTitle("Check In", for: .normal)
    eventDescription.numberOfLines = 10
  }
}
