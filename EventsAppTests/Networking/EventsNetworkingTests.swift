//
//  EventsNetworkingTests.swift
//  EventsAppTests
//
//  Created by Luis Gustavo Avelino de Lima Jacinto on 22/12/20.
//

import XCTest
import Combine
import Alamofire
@testable import EventsApp

class EventsNetworkingTests: XCTestCase {

  // MARK: - Properties
  let eventNetworking = EventsNetworking(networking: AnyNetworking(network: MockDataNetworking()))
  var cancellable = Set<AnyCancellable>()

  // MARK: - Setup
  override func setUp() {
    super.setUp()
  }

  // MARK: - Tests
  func testRequestEventsValidData() {
    let responseExpection = expectation(description: "Wait for valid events response")

    eventNetworking
      .requestEvents()
      .sink { _ in } receiveValue: { events in
        XCTAssertEqual(2, events.count)
        XCTAssertEqual("title", events[0].title)
        XCTAssertEqual("title2", events[1].title)
        responseExpection.fulfill()
      }.store(in: &cancellable)

    wait(for: [responseExpection], timeout: 1.0)
  }

  // MARK: - TeardDown
  override func tearDown() {
    super.tearDown()
  }

}
