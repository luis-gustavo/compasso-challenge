//
//  MockCheckInNetworking.swift
//  EventsAppTests
//
//  Created by Luis Gustavo Avelino de Lima Jacinto on 22/12/20.
//

import Foundation
import Alamofire
import Combine
@testable import EventsApp

final class MockCheckInNetworking: Networking {
  func request(url: URL, method: HTTPMethod, parameters: AnyEncodable?, encoder: ParameterEncoder?) -> AnyPublisher<NetworkResponse<Data>, NetworkError> {
    return Result.Publisher(.success(.empty(.ok))).eraseToAnyPublisher()
  }
}
