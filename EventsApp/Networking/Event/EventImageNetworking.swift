//
//  EventImageNetworking.swift
//  EventsApp
//
//  Created by Luis Gustavo Avelino de Lima Jacinto on 22/12/20.
//

import UIKit
import Combine

final class EventImageNetworking {

  // MARK: - Properties
  let networking: AnyNetworking<UIImage>

  // MARK: - Init
  init(networking: AnyNetworking<UIImage> = AnyNetworking(network: ImageNetworking())) {
    self.networking = networking
  }

  func requestEventImage(url: URL) -> AnyPublisher<UIImage, NetworkError> {
    return networking
      .request(url: url, method: .get, parameters: nil, encoder: nil)
      .tryMap { networkResponse -> UIImage in
        switch networkResponse {
        case let .nonEmpty(image, _): return image
        case .empty: throw NetworkError.emptyResponse
        }
      }
      .mapError({ $0 as? NetworkError ?? .unknown($0) })
      .eraseToAnyPublisher()
  }

}
