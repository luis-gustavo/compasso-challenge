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
  static let identifier = "EventsTableViewCell"
  let eventImage = EventImage(frame: .zero)
  let eventTitle = UILabel(frame: .zero)
  fileprivate let padding = CGFloat(20)
  

  // MARK: - Inits
  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: .default, reuseIdentifier: reuseIdentifier)

    setupView()
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}

// MARK: - ViewCodable Extension
extension EventsTableViewCell: ViewCodable {

  func buildViewHierarchy() {
    addSubview(eventImage)
    addSubview(eventTitle)
  }

  func setupConstraints() {
    eventImage.snp.makeConstraints { make in
      make.left.equalToSuperview().offset(padding)
      make.top.equalToSuperview().offset(padding/2)
      make.bottom.equalToSuperview().inset(padding/2)
      make.width.equalToSuperview().multipliedBy(0.2)
    }

    eventTitle.snp.makeConstraints{ make in
      make.centerY.equalTo(eventImage)
      make.left.equalTo(eventImage.snp.right).offset(padding)
      make.right.equalToSuperview().inset(padding)
    }
  }

  func setupAdditionalConfiguration() {
    eventTitle.numberOfLines = 5
    eventTitle.textColor = Colors.customYellow
    eventImage.state = .idle
    backgroundColor = Colors.customDarkBlue
  }
}
