//
//  MainCoordinator.swift
//  EventsApp
//
//  Created by Luis Gustavo Avelino de Lima Jacinto on 18/12/20.
//

import UIKit

final class MainCoordinator: Coordinatable {

  let navigationController = UINavigationController()

  init() { }

  func start() {
    let eventsViewController = EventsViewController()
    navigationController.pushViewController(eventsViewController, animated: true)
  }
}
