//
//  EventsViewModelTest.swift
//  EventsAppTests
//
//  Created by Luis Gustavo Avelino de Lima Jacinto on 22/12/20.
//

import XCTest
@testable import EventsApp

class EventsViewModelTest: XCTestCase {

  // MARK: - Properties
  let viewModel = EventsViewModel()
  private let mock = EventsViewModelDelegateMock()

  // MARK: - Setup
  override func setUp() {
    super.setUp()
    viewModel.delegate = mock
  }

  // MARK: - Tests

  // MARK: - TeardDown
  override func tearDown() {
    super.tearDown()

    viewModel.delegate = nil
  }

}

private final class EventsViewModelDelegateMock: EventsViewModelDelegate {
  func eventsViewModeldidUpdateEvents(_ events: [Event]) {
    
  }
}
