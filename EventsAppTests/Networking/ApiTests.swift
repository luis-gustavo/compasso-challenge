//
//  ApiTests.swift
//  EventsAppTests
//
//  Created by Luis Gustavo Avelino de Lima Jacinto on 22/12/20.
//

import XCTest
@testable import EventsApp

class ApiTests: XCTestCase {

  // MARK: - Properties

  // MARK: - Setup
  override func setUp() {
    super.setUp()
  }

  // MARK: - Tests
  func testEventsUrlCorrectValue() {
    guard let url = URL(string: "http://5f5a8f24d44d640016169133.mockapi.io/api/events") else {
      XCTFail("The url must exist")
      return
    }

    XCTAssertEqual(url, Api.eventsUrl)
  }

  func testCheckInUrlCorrectValue() {
    guard let url = URL(string: "http://5f5a8f24d44d640016169133.mockapi.io/api/checkin") else {
      XCTFail("The url must exist")
      return
    }

    XCTAssertEqual(url, Api.checkinUrl)
  }

  // MARK: - TeardDown
  override func tearDown() {
    super.tearDown()
  }

}
