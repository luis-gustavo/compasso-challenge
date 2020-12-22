//
//  CheckInViewModel.swift
//  EventsApp
//
//  Created by Luis Gustavo Avelino de Lima Jacinto on 20/12/20.
//

import Foundation
import Combine

final class CheckInViewModel {

  // MARK: - Properties
  var delegate: CheckInViewModelDelegate?
  let eventId: String
  weak var coordinator: MainCoordinator?
  fileprivate var name = ""
  fileprivate var email = ""
  fileprivate var cancellabe = Set<AnyCancellable>()

  // MARK: - Init
  init(eventId: String) {
    self.eventId = eventId
  }

  // MARK: - Methods
  func validateForm(name: String, email: String) {
    if (isNameValid(name) && isEmailValid(email)) {
      delegate?.confirmButtonStateChanged(true)
    } else {
      delegate?.confirmButtonStateChanged(false)
    }
  }

  func makeCheckIn() {
    let checkIn = CheckIn(eventId: eventId, name: name, email: email)

    CheckInNetworking()
      .makeCheckIn(checkIn)
      .receive(on: RunLoop.main)
      .sink { completion in
        switch completion {
        case let .failure(networkError):
          print(networkError)
          self.delegate?.didMakeCheckIn(code: nil, networkError: networkError)
        case .finished:
          debugPrint("Finished")
          break
        }
      } receiveValue: { httpStatusCode in
        print(httpStatusCode.rawValue)
        self.delegate?.didMakeCheckIn(code: httpStatusCode, networkError: nil)
      }.store(in: &cancellabe)
  }

  fileprivate func isNameValid(_ name: String) -> Bool {
    return !name.isEmpty
  }

  fileprivate func isEmailValid(_ email: String) -> Bool {
    let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
    let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
    return emailPred.evaluate(with: email)
  }
}
