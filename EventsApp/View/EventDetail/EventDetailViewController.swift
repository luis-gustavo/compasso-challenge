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
  var shareImage: UIImage {
    guard let shareImage = UIImage(named: "share") else {
      preconditionFailure("Share image must exist")
    }
    return shareImage
  }
  
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
    setupShareButton()
  }

  // MARK: - Deinit
  deinit {
    screen.checkinButton.removeTarget(self, action: nil, for: .touchUpInside)
  }

  // MARK: - Methods
  func setup() {
    setupEventDescription()
    setupEventImage()
    setupCheckInButtonTarget()
    setupEventPrice()
    setupEventDate()
  }

  @objc func checkInButtonTapped() {
    coordinator?.presentCheckInAlert(eventId: event.id)
  }

  @objc func didTapShareButton() {
    coordinator?.presentActivityViewController(event: event)
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

  fileprivate func setupShareButton() {
    navigationItem.rightBarButtonItem = UIBarButtonItem(image: shareImage, style: .done, target: self, action: #selector(didTapShareButton))
  }

  fileprivate func setupEventPrice() {
    let numberFormatter = NumberFormatter()
    numberFormatter.numberStyle = .currency
    screen.eventPrice.text = numberFormatter.string(from: NSNumber(value: event.price))
  }

  fileprivate func setupEventDate() {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "dd/MM/yyyy"
    screen.eventDate.text = dateFormatter.string(from: event.date)
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
