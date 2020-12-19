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
  var cachedImages = [Int : UIImage]()
  fileprivate var cancellables = Set<AnyCancellable>()
  fileprivate var delegate: EventsViewModelDelegate?

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
      self.events = events
    }.store(in: &cancellables)
  }

  func getEventImage(eventId: Int) {
    
  }
}
