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
  }

  // MARK: - ViewDidLoad
  override func viewDidLoad() {
    super.viewDidLoad()
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
  func buildViewHierarchy() { }

  func setupConstraints() { }

  func setupAdditionalConfiguration() {
    screen.tableView.register(EventsTableViewCell.self, forCellReuseIdentifier: EventsTableViewCell.identifier)
    screen.tableView.delegate = self
    screen.tableView.dataSource = self
  }
}

// MARK: - TableView Extensions

extension EventsViewController: UITableViewDelegate {

  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return view.bounds.size.height * 0.1
  }
}

extension EventsViewController: UITableViewDataSource {

  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return viewModel.events.count
  }

  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let cell = tableView.dequeueReusableCell(withIdentifier: EventsTableViewCell.identifier, for: indexPath) as? EventsTableViewCell else {
      assertionFailure("The cell must be of type EventsTableViewCell")
      return UITableViewCell()
    }

    let event = viewModel.events[indexPath.row]
    cell.eventTitle.text = event.title

    DispatchQueue.global().async { [weak self] in
      self?.viewModel.getEventImage(event: event, { image in
        cell.eventImage.image = image
      })
    }

    return cell
  }
}

// MARK: - ViewModel Extension
extension EventsViewController: EventsViewModelDelegate {
  func eventsViewModeldidUpdateEvents() {
    #warning("Trocar o reload data por begin e end update")
    self.screen.tableView.reloadData()
  }
}
