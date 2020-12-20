//
//  MainCoordinator.swift
//  EventsApp
//
//  Created by Luis Gustavo Avelino de Lima Jacinto on 18/12/20.
//

import UIKit

final class MainCoordinator: Coordinatable {

  let navigationController: UINavigationController

  init(navigationController: UINavigationController) {
    self.navigationController = navigationController
  }

  func start() {
    let eventsViewController = EventsViewController()
    eventsViewController.coordinator = self
    navigationController.pushViewController(eventsViewController, animated: false)
  }

  func showEventDetail(event: Event) {
    print(#function)
    let eventDetailViewController = EventDetailViewController(event: event)
    navigationController.pushViewController(eventDetailViewController, animated: false)
  }
}
