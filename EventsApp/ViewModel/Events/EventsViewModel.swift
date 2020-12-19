//
//  EventsViewModel.swift
//  EventsApp
//
//  Created by Luis Gustavo Avelino de Lima Jacinto on 19/12/20.
//

import UIKit
import Combine

final class EventsViewModel {

  // MARK: - Properties
  var events = [Event]() {
    didSet {
      delegate?.eventsViewModeldidUpdateEvents()
    }
  }
  var delegate: EventsViewModelDelegate?
  fileprivate var cancellables = Set<AnyCancellable>()


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

  func getEventImage(event: Event, _ completion: @escaping (UIImage) -> Void) {
    guard let url = URL(string: event.image) else {
      debugPrint("URL must exist from image path")
      return
    }

    EventNetworking
      .getEventImage(url: url).sink { completion in
        switch completion {
        case let .failure(networkError):
          print(networkError)
        case .finished:
          debugPrint("Finished")
          break
        }
      } receiveValue: { image in
        completion(image)
      }.store(in: &cancellables)
  }
}
