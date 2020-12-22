//
//  CheckInViewModelTests.swift
//  EventsAppTests
//
//  Created by Luis Gustavo Avelino de Lima Jacinto on 22/12/20.
//

import XCTest
@testable import EventsApp

class CheckInViewModelTests: XCTestCase {

  // MARK: - Properties
  let viewModel = CheckInViewModel(eventId: "1")
  private let mock = CheckInViewModelDelegateMock()

  // MARK: - Setup
  override func setUp() {
    super.setUp()
    viewModel.delegate = mock
  }

  // MARK: - Tests
  func testValidateFormWithValidData() {
    let name = "test"
    let email = "test@gmail.com"

    viewModel.validateForm(name: name, email: email)

    XCTAssertEqual(true, mock.enabled)
  }

  func testValidateFormWithInvalidData() {
    let name = ""
    let email = "abcd"

    viewModel.validateForm(name: name, email: email)

    XCTAssertEqual(false, mock.enabled)
  }

  // MARK: - TearDown
  override func tearDown() {
    super.tearDown()
    viewModel.delegate = nil
    mock.tearDown()
  }

}

// MARK: - CheckInViewModelDelegateMock
private final class CheckInViewModelDelegateMock: CheckInViewModelDelegate {
  var enabled: Bool? = nil

  func tearDown() {
    self.enabled = nil
  }

  func confirmButtonStateChanged(_ enable: Bool) {
    self.enabled = enable
  }

  func didMakeCheckIn(code: HTTPStatusCode?, networkError: NetworkError?) {

  }
}
