//
//  EventsNetworkingTests.swift
//  EventsAppTests
//
//  Created by Luis Gustavo Avelino de Lima Jacinto on 22/12/20.
//

import XCTest
import Combine
@testable import EventsApp

class EventsNetworkingTests: XCTestCase {

  // MARK: - Properties
  let eventNetworking = EventNetworking(networking: AnyNetworking(network: MockDataNetworking()))
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

private final class MockDataNetworking: Networking {

  var eventsData: Data {
    let events = [
      Event(people: [], date: Date(), description: "description", image: "image", longitude: 1, latitude: 1, price: 1, title: "title", id: "id"),
      Event(people: [], date: Date(), description: "description2", image: "image2", longitude: 2, latitude: 2, price: 2, title: "title2", id: "id2")
    ]
    do {
      return try JSONEncoder().encode(events)
    } catch {
      fatalError("Events must be encodable")
    }
  }

  func request(url: URL) -> AnyPublisher<NetworkResponse<Data>, NetworkError> {
    return Result.Publisher(.success(.nonEmpty(eventsData, .ok))).eraseToAnyPublisher()
  }
}
