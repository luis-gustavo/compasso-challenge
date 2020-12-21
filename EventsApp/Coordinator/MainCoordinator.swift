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

  func presentCheckInAlert(eventId: String) {
    let alert = CheckInAlertViewController(eventId: eventId)
    alert.providesPresentationContextTransitionStyle = true
    alert.definesPresentationContext = true
    alert.coordinator = self
    alert.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
    alert.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
    navigationController.present(alert, animated: true, completion: nil)
  }

  func presentCheckInResult(code: HTTPStatusCode?, networkError: NetworkError?) {
    let alert = CheckInResultAlertViewController(code: code, networkError: networkError)
    alert.definesPresentationContext = true
    alert.coordinator = self
    alert.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
    alert.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
    navigationController.dismiss(animated: false) {
      self.navigationController.present(alert, animated: true)
    }
  }

  func dismissAlerts() {
    navigationController.dismiss(animated: true, completion: nil)
  }

  func presentActivityViewController(event: Event) {
    let activityViewController = UIActivityViewController(activityItems: [event.title, event.description], applicationActivities: nil)
    activityViewController.popoverPresentationController?.sourceView = navigationController.visibleViewController?.view
    navigationController.present(activityViewController, animated: true, completion: nil)
  }
}
