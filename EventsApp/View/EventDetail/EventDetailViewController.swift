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

  // MARK: - Inits
  init(event: Event) {
    self.event = event
    super.init(nibName: nil, bundle: nil)
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  // MARK: - LoadView
  override func loadView() {
    super.loadView()

    view = screen
  }
}
