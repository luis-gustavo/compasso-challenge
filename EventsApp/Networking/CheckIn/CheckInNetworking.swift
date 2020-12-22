//
//  CheckInNetworking.swift
//  EventsApp
//
//  Created by Luis Gustavo Avelino de Lima Jacinto on 20/12/20.
//

import Foundation
import Combine
import Alamofire

final class CheckInNetworking {
  // MARK: - Properties
  let networking: AnyNetworking<Data>

  // MARK: - Init
  init(networking: AnyNetworking<Data> = AnyNetworking(network: DataNetworking())) {
    self.networking = networking
  }

  func makeCheckIn(_ checkIn: CheckIn) -> AnyPublisher<HTTPStatusCode, NetworkError> {
    networking
      .request(url: Api.checkinUrl,
               method: .post,
               parameters: AnyEncodable(checkIn),
               encoder: Alamofire.JSONParameterEncoder.default)
      .tryMap { networkResponse -> HTTPStatusCode in

        let statusCode = networkResponse.status
        if (statusCode.rawValue >= 200 && statusCode.rawValue <= 299) {
          return statusCode
        } else {
          throw NetworkError.emptyResponse
        }
      }
      .mapError({ $0 as? NetworkError ?? .unknown($0) })
      .eraseToAnyPublisher()
  }
}
