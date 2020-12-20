//
//  EventsViewControllerScreen.swift
//  EventsApp
//
//  Created by Luis Gustavo Avelino de Lima Jacinto on 18/12/20.
//

import UIKit
import SnapKit

final class EventsViewControllerScreen: UIView {

  // MARK: - Properties
  var tableView: UITableView = UITableView(frame: .zero)

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
extension EventsViewControllerScreen: ViewCodable {
  func buildViewHierarchy() {
    addSubview(tableView)
  }

  func setupConstraints() {
    tableView.snp.makeConstraints { make in
      make.left.top.bottom.right.equalToSuperview()
    }
  }

  func setupAdditionalConfiguration() {
    tableView.separatorStyle = .none
  }
}
