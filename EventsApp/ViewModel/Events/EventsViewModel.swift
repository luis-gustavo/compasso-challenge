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
      delegate?.eventsViewModeldidUpdateEvents(events)
    }
  }
  var delegate: EventsViewModelDelegate?
  fileprivate var cancellables = Set<AnyCancellable>()

  // MARK: - Methods
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

  func getEventImage(event: Event,
                     success: @escaping (UIImage) -> Void,
                     failure: @escaping (NetworkError) -> Void) {
    guard let url = URL(string: event.image) else {
      debugPrint("URL must exist from image path")
      return
    }

    EventNetworking
      .getEventImage(url: url).sink { completion in
        switch completion {
        case let .failure(networkError):
          failure(networkError)
          debugPrint(networkError)
        case .finished:
          debugPrint("Finished")
          break
        }
      } receiveValue: { image in
        success(image)
      }.store(in: &cancellables)
  }
}
