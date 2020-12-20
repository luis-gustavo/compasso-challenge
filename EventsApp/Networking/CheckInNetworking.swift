//
//  CheckInNetworking.swift
//  EventsApp
//
//  Created by Luis Gustavo Avelino de Lima Jacinto on 20/12/20.
//

import Foundation
import Combine
import Alamofire

struct CheckInNetworking {

  static func makeCheckIn(_ checkIn: CheckIn) -> AnyPublisher<HTTPStatusCode, NetworkError> {
    return Future<NetworkResponse<HTTPStatusCode>, NetworkError> { promise in
      AF.request(Api.checkinUrl, method: .post, parameters: checkIn, encoder: Alamofire.JSONParameterEncoder.default).responseData { response  in
        guard let statusCode = response.response?.status else {
          promise(.failure(.withoutResponse))
          return
        }
        promise(.success(.nonEmpty(statusCode, statusCode)))
      }
    }
    .tryMap({ networkResponse -> HTTPStatusCode in
      switch networkResponse {
      case let .nonEmpty(statusCode, _): return statusCode
      case .empty: throw NetworkError.emptyResponse
      }
    })
    .mapError({ $0 as? NetworkError ?? .unknown($0) })
    .eraseToAnyPublisher()
  }

}
