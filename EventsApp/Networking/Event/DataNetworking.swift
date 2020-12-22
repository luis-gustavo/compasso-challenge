//
//  DataNetworking.swift
//  EventsApp
//
//  Created by Luis Gustavo Avelino de Lima Jacinto on 22/12/20.
//

import Foundation
import Combine
import Alamofire

final class DataNetworking: Networking {
  func request(url: URL, method: HTTPMethod, parameters: AnyEncodable?, encoder: ParameterEncoder?) -> AnyPublisher<NetworkResponse<Data>, NetworkError> {
    return Future<NetworkResponse<Data>, NetworkError> { promise in
      AF.request(url,
                 method: method,
                 parameters: parameters,
                 encoder: encoder != nil ? Alamofire.JSONParameterEncoder.default : URLEncodedFormParameterEncoder.default)
        .responseData { response in

          guard let statusCode = response.response?.status else {
            promise(.failure(.withoutResponse))
            return
          }


          if let error = response.error {
            promise(.failure(.unknown(error)))
            return
          }

          if let data = response.data {
            promise(.success(.nonEmpty(data, statusCode)))
          } else {
            promise(.success(.empty(statusCode)))
          }
        }
    }
    .eraseToAnyPublisher()
  }
}
