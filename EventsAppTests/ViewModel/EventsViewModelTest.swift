//
//  EventsViewModelTest.swift
//  EventsAppTests
//
//  Created by Luis Gustavo Avelino de Lima Jacinto on 22/12/20.
//

import XCTest
import Alamofire
import Combine
@testable import EventsApp

class EventsViewModelTest: XCTestCase {

  // MARK: - Properties
  lazy var viewModel = EventsViewModel(eventsNetworking: EventsNetworking(networking: AnyNetworking(network: MockDataNetworking())),
                                  eventImageNetworking: EventImageNetworking(networking: AnyNetworking(network: mockImageNetworking)))
  private lazy var mock = EventsViewModelDelegateMock {
    self.eventsExpection.fulfill()
  }
  let mockImageNetworking = MockImageNetworking()
  lazy var eventsExpection = expectation(description: "Wait for events response")

  // MARK: - Setup
  override func setUp() {
    super.setUp()
    viewModel.delegate = mock
  }

  // MARK: - Tests

  func testGetImageWithValidData() {
    let imageExpectation = expectation(description: "Wait for event image")
    let event = Event(people: [],
                      date: Date(),
                      description: "",
                      image: "google.com",
                      longitude: 1,
                      latitude: 1,
                      price: 1,
                      title: "",
                      id: "2")

    viewModel.getEventImage(event: event) { image in
      XCTAssertEqual(self.mockImageNetworking.eventImage, image)
      imageExpectation.fulfill()
    } failure: { _ in }

    wait(for: [imageExpectation], timeout: 1.0)
  }

  func testGetEventsWithValidData() {
    viewModel.getEvents()

    wait(for: [eventsExpection], timeout: 1.0)
  }

  // MARK: - TeardDown
  override func tearDown() {
    super.tearDown()

    viewModel.delegate = nil
  }

}

private final class EventsViewModelDelegateMock: EventsViewModelDelegate {

  let completion: () -> Void

  init(completion: @escaping () -> Void) {
    self.completion = completion
  }

  func eventsViewModeldidUpdateEvents(_ events: [Event]) {
    XCTAssertEqual(2, events.count)
    XCTAssertEqual("title", events[0].title)
    XCTAssertEqual("title2", events[1].title)
    completion()
  }
}
