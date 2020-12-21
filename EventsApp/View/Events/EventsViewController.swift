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
  weak var coordinator: MainCoordinator?

  // MARK: - LoadView
  override func loadView() {
    super.loadView()
    view = screen
    setupView()
  }

  // MARK: - ViewDidLoad
  override func viewDidLoad() {
    super.viewDidLoad()
    setup()
    fetchEvents()
  }

  // MARK: - Methods
  func fetchEvents() {
    viewModel.getEvents()
  }

  func setup() {
    setupTableView()
    setupViewModel()
  }

}

// MARK: - Setup methods Extension
extension EventsViewController {
  fileprivate func setupTableView() {
    screen.tableView.register(EventsTableViewCell.self, forCellReuseIdentifier: EventsTableViewCell.identifier)
    screen.tableView.delegate = self
    screen.tableView.dataSource = self
  }

  fileprivate func setupViewModel() {
    viewModel.delegate = self
  }
}

// MARK: - ViewCodableExtension
extension EventsViewController: ViewCodable {
  func buildViewHierarchy() { }

  func setupConstraints() { }

  func setupAdditionalConfiguration() {
    title = "Events"
    navigationController?.navigationBar.barTintColor = Colors.customYellow
    navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: Colors.customDarkBlue]
  }
}

// MARK: - TableView Extensions
extension EventsViewController: UITableViewDelegate {

  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return view.bounds.size.height * 0.15
  }

  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    let event = viewModel.events[indexPath.row]
    coordinator?.showEventDetail(event: event)
    tableView.deselectRow(at: indexPath, animated: true)
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
    cell.eventImage.state = .fetching

    DispatchQueue.global().async { [weak self] in
      self?.viewModel.getEventImage(event: event, success: { image in
        DispatchQueue.main.async { [weak cell] in
          cell?.eventImage.state = .fetched(success: true)
          cell?.eventImage.image = image
        }
      }, failure: { networkError in
        DispatchQueue.main.async { [weak cell] in
          cell?.eventImage.state = .fetched(success: false)
        }
      })
    }

    return cell
  }
}

// MARK: - ViewModel Extension
extension EventsViewController: EventsViewModelDelegate {
  func eventsViewModeldidUpdateEvents(_ events: [Event]) {
    screen.tableView.beginUpdates()
    for row in 0..<events.count {
      screen.tableView.insertRows(at: [IndexPath(row: row, section: 0)], with: .fade)
    }
    screen.tableView.endUpdates()
  }
}
