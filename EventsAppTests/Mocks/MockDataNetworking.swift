//
//  MockDataNetworking.swift
//  EventsAppTests
//
//  Created by Luis Gustavo Avelino de Lima Jacinto on 22/12/20.
//

import Foundation
import Alamofire
import Combine
@testable import EventsApp

final class MockDataNetworking: Networking {
  var eventsData: Data {
    let events = [
      Event(people: [], date: Date(), description: "description", image: "image", longitude: 1, latitude: 1, price: 1, title: "title", id: "id"),
      Event(people: [], date: Date(), description: "description2", image: "image2", longitude: 2, latitude: 2, price: 2, title: "title2", id: "id2")
    ]
    do {
      return try JSONEncoder().encode(events)
    } catch {
      preconditionFailure("Events must be encodable")
    }
  }

  func request(url: URL, method: HTTPMethod, parameters: AnyEncodable?, encoder: ParameterEncoder?) -> AnyPublisher<NetworkResponse<Data>, NetworkError> {
    return Result.Publisher(.success(.nonEmpty(eventsData, .ok))).eraseToAnyPublisher()
  }
}
