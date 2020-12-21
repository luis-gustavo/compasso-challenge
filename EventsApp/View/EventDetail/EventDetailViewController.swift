//
//  EventDetailViewController.swift
//  EventsApp
//
//  Created by Luis Gustavo Avelino de Lima Jacinto on 20/12/20.
//

import UIKit

final class EventDetailViewController: UIViewController {

  // MARK: - Properties

  let event: Event
  let eventsViewModel = EventsViewModel()
  lazy var screen = EventDetailViewControllerScreen(frame: view.bounds)
  lazy var checkInViewModel = CheckInViewModel(eventId: event.id)
  weak var coordinator: MainCoordinator?

  // MARK: - Inits
  init(event: Event) {
    self.event = event
    super.init(nibName: nil, bundle: nil)
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  // MARK: - ViewDidLoad
  override func viewDidLoad() {
    super.viewDidLoad()
    setup()
  }

  // MARK: - LoadView
  override func loadView() {
    super.loadView()
    view = screen
    setupView()
  }

  // MARK: - Deinit
  deinit {
    screen.checkinButton.removeTarget(self, action: nil, for: .touchUpInside)
  }

  // MARK: - Methods
  func setup() {
    setupEventDescription()
    setupEventImage()
    setupViewCheckInViewModelDelegate()
    setupCheckInButtonTarget()
  }

  @objc func checkInButtonTapped() {
    coordinator?.presentCheckInAlert(eventDetailViewController: self)
  }
}

// MARK: - Setup methods Extension
extension EventDetailViewController {
  fileprivate func setupEventDescription() {
    screen.eventDescription.text = event.description
  }

  fileprivate func setupCheckInButtonTarget() {
    screen.checkinButton.addTarget(self, action: #selector(checkInButtonTapped), for: .touchUpInside)
  }

  fileprivate func setupViewCheckInViewModelDelegate() {
    checkInViewModel.delegate = self
  }

  fileprivate func setupEventImage() {
    screen.eventImage.state = .fetching
    DispatchQueue.global().async { [weak self] in
      guard let self = self else { return }
      self.eventsViewModel.getEventImage(event: self.event) { image in
        DispatchQueue.main.async { [weak self] in
          guard let self = self else { return }
          self.screen.eventImage.state = .fetched(success: true)
          self.screen.eventImage.image = image
        }
      } failure: { networkError in
        DispatchQueue.main.async { [weak self] in
          guard let self = self else { return }
          self.screen.eventImage.state = .fetched(success: false)
        }
      }
    }
  }
}

// MARK: - ViewCodable Extension
extension EventDetailViewController: ViewCodable {
  func buildViewHierarchy() { }

  func setupConstraints() { }

  func setupAdditionalConfiguration() {
    title = event.title
  }
}

// MARK: - CheckInAlertViewDelegate Extension
extension EventDetailViewController: CheckInAlertViewDelegate {
  func textFieldEditingChanged(name: UITextField, email: UITextField) {
    checkInViewModel.validateForm(name: name.text ?? "", email: email.text ?? "")
  }

  func cancelButtonClicked(_ sender: CheckInAlertViewController) {
    coordinator?.dismissAlerts()
  }

  func confirmButtonClicked(_ sender: CheckInAlertViewController) {
    checkInViewModel.makeCheckIn()
  }
}

// MARK: - CheckInViewModelDelegate Extension
extension EventDetailViewController: CheckInViewModelDelegate {
  func confirmButtonStateChanged(_ enable: Bool) {

  }

  func nameStateChanged(_ isValid: Bool) {
    if (isValid) {

    } else {

    }
  }

  func emailStateChanged(_ isValid: Bool) {
    if (isValid) {

    } else {

    }
  }
}
