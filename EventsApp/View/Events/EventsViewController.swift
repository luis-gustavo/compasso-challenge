//
//  EventsViewController.swift
//  EventsApp
//
//  Created by Luis Gustavo Avelino de Lima Jacinto on 18/12/20.
//

import UIKit

final class EventsViewController: UIViewController {

  lazy var screen = EventsViewControllerScreen(frame: view.bounds)

  // MARK: - LoadView
  override func loadView() {
    super.loadView()
    view = screen
    setupView()
  }
}

extension EventsViewController: ViewCodable {
  func buildViewHierarchy() {

  }

  func setupConstraints() {

  }

  func setupAdditionalConfiguration() {
    screen.tableView.register(EventsTableViewCell.self, forCellReuseIdentifier: EventsTableViewCell.identifier)
    screen.tableView.delegate = self
    screen.tableView.dataSource = self
  }
}

extension EventsViewController: UITableViewDelegate { }

extension EventsViewController: UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 5
  }

  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let cell = tableView.dequeueReusableCell(withIdentifier: EventsTableViewCell.identifier, for: indexPath) as? EventsTableViewCell else {
      assertionFailure("The cell must be of type EventsTableViewCell")
      return UITableViewCell()
    }

    return cell
  }
}
