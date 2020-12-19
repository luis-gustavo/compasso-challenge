//
//  EventsViewModel.swift
//  EventsApp
//
//  Created by Luis Gustavo Avelino de Lima Jacinto on 19/12/20.
//

import Foundation
import Combine

final class EventsViewModel {

  // MARK: - Properties
  var events = [Event]() {
    didSet {
      delegate?.eventsViewModeldidUpdateEvents()
    }
  }
  var cancellables = Set<AnyCancellable>()
  var delegate: EventsViewModelDelegate?

  func getEvents() {
    EventNetworking
      .getEvents()
      .receive(on: RunLoop.main)
      .sink { completion in
      switch completion {
      case let .failure(networkError):
        print(networkError)
      case .finished:
        debugPrint("Finished")
        break
      }
    } receiveValue: { events in
      events.forEach({ print($0) })
      self.events = events
    }.store(in: &cancellables)
  }
}
