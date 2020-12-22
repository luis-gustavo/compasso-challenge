//
//  AnyNetworking.swift
//  EventsApp
//
//  Created by Luis Gustavo Avelino de Lima Jacinto on 22/12/20.
//

import Combine
import Foundation
import Alamofire

final class AnyNetworking<T: Hashable>: Networking {
  private let requestedObject: (URL, HTTPMethod, AnyEncodable?, ParameterEncoder?) -> AnyPublisher<NetworkResponse<T>, NetworkError>

  init<Network: Networking>(network: Network) where Network.T == T {
    self.requestedObject = network.request
  }

  func request(url: URL, method: HTTPMethod, parameters: AnyEncodable?, encoder: ParameterEncoder?) -> AnyPublisher<NetworkResponse<T>, NetworkError> {
    return requestedObject(url, method, parameters, encoder)
  }
}
