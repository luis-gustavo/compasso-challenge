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
  }
}

