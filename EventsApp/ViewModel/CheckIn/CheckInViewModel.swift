//
//  CheckInViewModel.swift
//  EventsApp
//
//  Created by Luis Gustavo Avelino de Lima Jacinto on 20/12/20.
//

import Foundation



final class CheckInViewModel {

  // MARK: - Properties
  var delegate: CheckInViewModelDelegate?
  private var name = ""
  private var email = ""

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

  fileprivate func isNameValid(_ name: String) -> Bool {
    return !name.isEmpty
  }

  fileprivate func isEmailValid(_ email: String) -> Bool {
    let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
    let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
    return emailPred.evaluate(with: email)
  }
}
