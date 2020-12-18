//
//  EventsTableViewCell.swift
//  EventsApp
//
//  Created by Luis Gustavo Avelino de Lima Jacinto on 18/12/20.
//

import UIKit
import SnapKit

final class EventsTableViewCell: UITableViewCell {

  // MARK: - Properties
  fileprivate let identifier = "EventsTableViewCell"

  lazy var eventImage: UIImageView = {
    let eventImage = UIImageView(frame: .zero)
    return eventImage
  }()

  lazy var eventTitle: UILabel = {
    let eventTitle = UILabel(frame: .zero)
    return eventTitle
  }()

  // MARK: - Inits
  init(frame: CGRect) {
    super.init(style: .default, reuseIdentifier: identifier)
    setupView()
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

}

extension EventsTableViewCell: ViewCodable {

  func buildViewHierarchy() {
    addSubview(eventImage)
    addSubview(eventTitle)
  }

  func setupConstraints() {
    eventImage.snp.makeConstraints { make in
      make.left.top.bottom.equalToSuperview()
      make.width.equalToSuperview().multipliedBy(0.2)
    }

    eventTitle.snp.makeConstraints{ make in
      make.centerY.equalTo(eventImage)
      make.left.equalTo(eventImage).offset(15)
      make.right.equalToSuperview().inset(15)
    }
  }

  func setupAdditionalConfiguration() {
    eventImage.image = UIImage(systemName: "UIBarButtonSystemItemEdit")
    eventTitle.text = "Nome do Event"
  }
}
