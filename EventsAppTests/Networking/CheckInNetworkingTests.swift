//
//  CheckInNetworkingTests.swift
//  EventsAppTests
//
//  Created by Luis Gustavo Avelino de Lima Jacinto on 22/12/20.
//

import XCTest
import Alamofire
import Combine
@testable import EventsApp

class CheckInNetworkingTests: XCTestCase {

  // MARK: - Properties
  let checkInNetworking = CheckInNetworking(networking: AnyNetworking(network: MockCheckInNetworking()))
  var cancellable = Set<AnyCancellable>()

  // MARK: - Setup
  override func setUp() {
    super.setUp()
  }

  // MARK: - Tests
  func testRequestEventsValidData() {
    let responseExpection = expectation(description: "Wait for valid events response")

    checkInNetworking
      .makeCheckIn(CheckIn(eventId: "", name: "", email: ""))
      .sink { _ in } receiveValue: { httpStatusCode in
        XCTAssertEqual(httpStatusCode, .ok)
        responseExpection.fulfill()
      }.store(in: &cancellable)

    wait(for: [responseExpection], timeout: 1.0)
  }

  // MARK: - TeardDown
  override func tearDown() {
    super.tearDown()
  }
}

private final class MockCheckInNetworking: Networking {
  func request(url: URL, method: HTTPMethod, parameters: AnyEncodable?, encoder: ParameterEncoder?) -> AnyPublisher<NetworkResponse<Data>, NetworkError> {
    return Result.Publisher(.success(.empty(.ok))).eraseToAnyPublisher()
  }
}
