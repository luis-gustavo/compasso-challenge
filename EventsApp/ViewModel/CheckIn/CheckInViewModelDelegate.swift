//
//  CheckInViewModelDelegate.swift
//  EventsApp
//
//  Created by Luis Gustavo Avelino de Lima Jacinto on 20/12/20.
//

import Foundation

protocol CheckInViewModelDelegate {
  func confirmButtonStateChanged(_ enable: Bool)
  func nameStateChanged(_ isValid: Bool)
  func emailStateChanged(_ isValid: Bool)
}
