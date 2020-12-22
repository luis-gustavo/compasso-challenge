//
//  EventImageTests.swift
//  EventsAppTests
//
//  Created by Luis Gustavo Avelino de Lima Jacinto on 22/12/20.
//

import XCTest
import Alamofire
import Combine
@testable import EventsApp

class EventImageNetworkingTests: XCTestCase {

  // MARK: - Properties
  lazy var  eventImageNetworking = EventImageNetworking(networking: AnyNetworking(network:mock))
  private let mock = MockImageNetworking()
  var cancellable = Set<AnyCancellable>()

  // MARK: - Setup
  override func setUp() {
    super.setUp()
  }

  // MARK: - Tests
  func testRequestEventsValidData() {
    let responseExpection = expectation(description: "Wait for valid events response")

    eventImageNetworking
      .requestEventImage(url: Api.eventsUrl)
      .sink { _ in } receiveValue: { image in
        XCTAssertEqual(image, self.mock.eventImage)
        responseExpection.fulfill()
      }.store(in: &cancellable)

    wait(for: [responseExpection], timeout: 1.0)
  }

  // MARK: - TeardDown
  override func tearDown() {
    super.tearDown()
  }

}

private final class MockImageNetworking: Networking {
  var eventImage: UIImage {
    guard let image = UIImage(named: "errorImage") else {
      preconditionFailure("Image must exist")
    }
    return image
  }

  func request(url: URL, method: HTTPMethod, parameters: AnyEncodable?, encoder: ParameterEncoder?) -> AnyPublisher<NetworkResponse<UIImage>, NetworkError> {
    return Result.Publisher(.success(.nonEmpty(eventImage, .ok))).eraseToAnyPublisher()
  }
}
