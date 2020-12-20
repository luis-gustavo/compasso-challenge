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
  fileprivate var name = ""
  fileprivate var email = ""
  fileprivate var cancellabe = Set<AnyCancellable>()

  // MARK: - Init
  init(eventId: String) {
    self.eventId = eventId
  }

  // MARK: - Methods
  func validateForm(name: String, email: String) {
    if (isNameValid(name)) {
      delegate?.nameStateChanged(true)
      if (isEmailValid(email)) {
        // Both Valid
        delegate?.emailStateChanged(true)
        delegate?.confirmButtonStateChanged(true)
      } else {
        // Just name is valid
        delegate?.emailStateChanged(false)
        delegate?.confirmButtonStateChanged(false)
      }
    } else {
      delegate?.nameStateChanged(false)
      delegate?.confirmButtonStateChanged(false)
      if (isEmailValid(email)) {
        // Just email is valid
        delegate?.emailStateChanged(true)
      } else {
        // Neither are valid
        delegate?.emailStateChanged(false)
      }
    }
  }

  func makeCheckIn() {
    let checkIn = CheckIn(eventId: eventId, name: name, email: email)

    CheckInNetworking
      .makeCheckIn(checkIn)
      .receive(on: RunLoop.main)
      .sink { completion in
        switch completion {
        case let .failure(networkError):
          print(networkError)
        case .finished:
          debugPrint("Finished")
          break
        }
      } receiveValue: { httpStatusCode in
        switch httpStatusCode.rawValue {
        case 200...299: debugPrint("success")
        default: debugPrint("error")
        }
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
