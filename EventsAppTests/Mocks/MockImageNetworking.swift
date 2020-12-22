//
//  MockImageNetworking.swift
//  EventsAppTests
//
//  Created by Luis Gustavo Avelino de Lima Jacinto on 22/12/20.
//

import UIKit
import Alamofire
import Combine
@testable import EventsApp

final class MockImageNetworking: Networking {
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
