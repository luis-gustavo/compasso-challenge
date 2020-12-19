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
  var eventImage: UIImageView = UIImageView(frame: .zero)
  var eventTitle: UILabel = UILabel(frame: .zero)

  // MARK: - Inits
  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: .default, reuseIdentifier: reuseIdentifier)

    setupView()
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  // MARK: - Methods
  func configureCell(with event: Event) {
    eventTitle.text = event.title
    #warning("Colocar imagem depois")
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
      make.left.top.bottom.equalToSuperview()
      make.width.equalToSuperview().multipliedBy(0.2)
    }

    eventTitle.snp.makeConstraints{ make in
      make.centerY.equalTo(eventImage)
      make.left.equalTo(eventImage.snp.right).offset(15)
      make.right.equalToSuperview().inset(15)
    }
  }

  func setupAdditionalConfiguration() {
    eventImage.image = UIImage(systemName: "info.circle")
    eventTitle.text = "Nome do Evento"
  }
}
