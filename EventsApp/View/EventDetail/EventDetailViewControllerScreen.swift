//
//  EventDetailViewControllerScreen.swift
//  EventsApp
//
//  Created by Luis Gustavo Avelino de Lima Jacinto on 20/12/20.
//

import UIKit

final class EventDetailViewControllerScreen: UIView {

  // MARK: - Properties
  let scrollView = UIScrollView(frame: .zero)
  let containerView = UIView(frame: .zero)
  let eventImage = EventImage(frame: .zero)
  let eventDescription = UILabel(frame: .zero)
  let checkinButton = UIButton(type: .system)
  let eventDate = UILabel(frame: .zero)
  let eventPrice = UILabel(frame: .zero)
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
    addSubview(scrollView)
    scrollView.addSubview(containerView)
    containerView.addSubview(eventImage)
    containerView.addSubview(eventDescription)
    containerView.addSubview(checkinButton)
    containerView.addSubview(eventPrice)
    containerView.addSubview(eventDate)
  }

  func setupConstraints() {

    scrollView.snp.makeConstraints { make in
      make.left.top.right.bottom.equalToSuperview()
    }

    containerView.snp.makeConstraints { make in
      make.left.top.right.bottom.equalToSuperview()
      make.width.equalTo(self)
    }

    eventImage.snp.makeConstraints { make in
      make.top.left.equalTo(self.safeAreaInsets.bottom).offset(padding)
      make.right.equalToSuperview().inset(padding)
      make.height.equalTo(self).multipliedBy(0.4)
    }

    eventPrice.snp.makeConstraints { make in
      make.top.equalTo(eventImage.snp.bottom).offset(padding/2)
      make.left.equalToSuperview().offset(padding)
      make.right.equalTo(eventImage.snp.centerX)
    }

    eventDate.snp.makeConstraints { make in
      make.left.equalTo(eventPrice.snp.right)
      make.top.equalTo(eventImage.snp.bottom).offset(padding/2)
      make.right.equalToSuperview().inset(padding)
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
      make.top.equalTo(eventPrice.snp.bottom).offset(padding)
    }
  }

  func setupAdditionalConfiguration() {
    checkinButton.setTitle("Check In", for: .normal)
    checkinButton.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: .bold)
    eventDescription.numberOfLines = 0
    eventDescription.sizeToFit()
    eventImage.activityIndicator.color = .black
    eventImage.state = .idle
    eventDate.textAlignment = .right
    eventPrice.textAlignment = .left
    backgroundColor = .white
  }
}
