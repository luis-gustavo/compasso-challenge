//
//  EventNetworking.swift
//  EventsApp
//
//  Created by Luis Gustavo Avelino de Lima Jacinto on 18/12/20.
//

import UIKit
import Alamofire
import Combine
import AlamofireImage

struct EventNetworking {

  static func getEvents() -> AnyPublisher<[Event], NetworkError> {

    return Future<NetworkResponse<Data>, NetworkError> { promise in

      AF.request(Api.eventsUrl).responseData { response in

        guard let statusCode = response.response?.status else {
          promise(.failure(.withoutResponse))
          return
        }

        if let data = response.data {
          promise(.success(.nonEmpty(data, statusCode)))
        } else {
          promise(.success(.empty(statusCode)))
        }
      }
    }
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

  static fileprivate let imageCache = AutoPurgingImageCache()
  static func getEventImage(url: URL) -> AnyPublisher<UIImage, NetworkError> {

    if let cachedImage = imageCache.image(withIdentifier: url.absoluteString) {
      return Result.Publisher(cachedImage).eraseToAnyPublisher()
    }

    return Future { promise in
      AF.request(url).responseImage { response in
        switch response.result {
        case .success(let image):
          imageCache.add(image, withIdentifier: url.absoluteString)
          promise(.success(image))
        case .failure(let error):
          promise(.failure(.dependency(error)))
        }
      }
    }
    .eraseToAnyPublisher()

  }
}
