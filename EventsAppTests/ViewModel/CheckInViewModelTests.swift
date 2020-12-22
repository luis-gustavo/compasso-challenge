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
  let viewModel = CheckInViewModel(checkInNetworking: CheckInNetworking(networking: AnyNetworking(network: MockCheckInNetworking())), eventId: "1")
  private lazy var mock = CheckInViewModelDelegateMock(expectation: checkInExpection)
  lazy var checkInExpection = expectation(description: "Wait for check in response")

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

    wait(for: [checkInExpection], timeout: 1.0)
    XCTAssertTrue(mock.enabled)
  }

  func testValidateFormWithInvalidData() {
    let name = ""
    let email = "abcd"

    viewModel.validateForm(name: name, email: email)

    wait(for: [checkInExpection], timeout: 1.0)
    XCTAssertFalse(mock.enabled)
  }

  func testMakeCheckInWithValidData() {
    viewModel.makeCheckIn()

    wait(for: [checkInExpection], timeout: 1.0)
  }

  // MARK: - TearDown
  override func tearDown() {
    super.tearDown()
    viewModel.delegate = nil
  }

}

// MARK: - CheckInViewModelDelegateMock
private final class CheckInViewModelDelegateMock: CheckInViewModelDelegate {

  let expectation: XCTestExpectation
  var enabled: Bool = false

  init(expectation: XCTestExpectation) {
    self.expectation = expectation
  }

  func confirmButtonStateChanged(_ enable: Bool) {
    self.enabled = enable
    expectation.fulfill()
  }

  func didMakeCheckIn(code: HTTPStatusCode?, networkError: NetworkError?) {
    XCTAssertEqual(code, .some(.ok))
    expectation.fulfill()
  }
}
