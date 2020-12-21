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
    navigationController.navigationBar.isTranslucent = false
  }

  func start() {
    let eventsViewController = EventsViewController()
    eventsViewController.coordinator = self
    navigationController.pushViewController(eventsViewController, animated: true)
  }

  func showEventDetail(event: Event) {
    let eventDetailViewController = EventDetailViewController(event: event)
    eventDetailViewController.coordinator = self
    navigationController.pushViewController(eventDetailViewController, animated: true)
  }

  func presentCheckInAlert(eventDetailViewController: EventDetailViewController) {
    let alert = CheckInAlertViewController()
    alert.providesPresentationContextTransitionStyle = true
    alert.definesPresentationContext = true
    alert.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
    alert.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
    alert.delegate = eventDetailViewController
    navigationController.present(alert, animated: true, completion: nil)
  }

  func dismissAlerts() {
    navigationController.dismiss(animated: true, completion: nil)
  }
}
