//
//  EventsViewController.swift
//  EventsApp
//
//  Created by Luis Gustavo Avelino de Lima Jacinto on 18/12/20.
//

import UIKit

final class EventsViewController: UIViewController {

  // MARK: - Properties
  lazy var screen = EventsViewControllerScreen(frame: view.bounds)
  let viewModel = EventsViewModel()

  // MARK: - LoadView
  override func loadView() {
    super.loadView()
    view = screen
    setupView()
    print(#function)
  }

  // MARK: - ViewDidLoad
  override func viewDidLoad() {
    super.viewDidLoad()
    print(#function)
    viewModel.delegate = self
    fetchEvents()
  }

  // MARK: - Methods
  func fetchEvents() {
    viewModel.getEvents()
  }
}

// MARK: - ViewCodableExtension
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

// MARK: - TableView Extensions

extension EventsViewController: UITableViewDelegate {

  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return view.bounds.size.height * 0.2
  }
}

extension EventsViewController: UITableViewDataSource {

  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    print(viewModel.events.count)
    return viewModel.events.count
  }

  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let cell = tableView.dequeueReusableCell(withIdentifier: EventsTableViewCell.identifier, for: indexPath) as? EventsTableViewCell else {
      assertionFailure("The cell must be of type EventsTableViewCell")
      return UITableViewCell()
    }

    let event = viewModel.events[indexPath.row]
    cell.configureCell(with: event)

    return cell
  }
}

// MARK: - ViewModel Extension
extension EventsViewController: EventsViewModelDelegate {
  func eventsViewModeldidUpdateEvents() {
    print(#function)
    DispatchQueue.main.async {
      #warning("Trocar o reload data por begin e end update")
      print(self.viewModel.events.count)
      self.screen.tableView.reloadData()
    }
  }
}
