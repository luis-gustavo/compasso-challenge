//
//  EventsNetworking.swift
//  EventsApp
//
//  Created by Luis Gustavo Avelino de Lima Jacinto on 22/12/20.
//

import Combine
import Foundation

final class EventsNetworking {

  // MARK: - Properties
  let networking: AnyNetworking<Data>

  // MARK: - Init
  init(networking: AnyNetworking<Data> = AnyNetworking(network: DataNetworking())) {
    self.networking = networking
  }

  // MARK: - Methods
  func requestEvents() -> AnyPublisher<[Event], NetworkError> {
    return networking.request(url: Api.eventsUrl, method: .get, parameters: nil, encoder: nil)
      .tryMap { networkResponse -> [Event] in
        switch networkResponse {
        case let .nonEmpty(data, _):
          do {
            let decoded = try JSONDecoder().decode([Event].self, from: data)
            return decoded
          } catch {
            throw NetworkError.decoding(error)
          }
        case .empty: throw NetworkError.emptyResponse
        }
      }
      .mapError({ $0 as? NetworkError ?? .unknown($0) })
      .eraseToAnyPublisher()
  }
}
