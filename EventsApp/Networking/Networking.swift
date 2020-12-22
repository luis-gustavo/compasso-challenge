//
//  Networking.swift
//  EventsApp
//
//  Created by Luis Gustavo Avelino de Lima Jacinto on 22/12/20.
//

import Foundation
import Combine
import Alamofire

protocol Networking {
  associatedtype T: Hashable
  func request(url: URL, method: HTTPMethod, parameters: AnyEncodable?, encoder: ParameterEncoder?) -> AnyPublisher<NetworkResponse<T>, NetworkError>
}
