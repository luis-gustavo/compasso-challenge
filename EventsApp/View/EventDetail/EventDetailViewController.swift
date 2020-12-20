//
//  EventDetailViewController.swift
//  EventsApp
//
//  Created by Luis Gustavo Avelino de Lima Jacinto on 20/12/20.
//

import UIKit

final class EventDetailViewController: UIViewController {

  // MARK: - Properties
  lazy var screen = EventDetailViewControllerScreen(frame: view.bounds)
  let event: Event
  let viewModel = EventsViewModel()

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

  // MARK: - Methods
  func setup() {
    setupEventDescription()
    setupEventImage()
  }
}

// MARK: - Setup methods Extension
extension EventDetailViewController {
  fileprivate func setupEventDescription() {
    screen.eventDescription.text = event.description
  }

  fileprivate func setupEventImage() {
    DispatchQueue.global().async { [weak self] in
      guard let self = self else { return }
      self.viewModel.getEventImage(event: self.event) { [weak self] (image) in
        guard let self = self else { return }
        DispatchQueue.main.async {
          self.screen.eventImage.image = image
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
