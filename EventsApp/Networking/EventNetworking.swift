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

protocol Networking {
  associatedtype T: Hashable
  func request(url: URL) -> AnyPublisher<NetworkResponse<T>, NetworkError>
}

final class AnyNetworking<T: Hashable>: Networking {
  private let requestedObject: (URL) -> AnyPublisher<NetworkResponse<T>, NetworkError>

  init<Network: Networking>(network: Network) where Network.T == T {
    self.requestedObject = network.request
  }

  func request(url: URL) -> AnyPublisher<NetworkResponse<T>, NetworkError> {
    return requestedObject(url)
  }
}

final class DataNetworking: Networking {
  func request(url: URL) -> AnyPublisher<NetworkResponse<Data>, NetworkError> {
    return Future<NetworkResponse<Data>, NetworkError> { promise in
      AF.request(url).responseData { response in
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
    .eraseToAnyPublisher()
  }
}

final class EventNetworking {

  // MARK: - Properties
  let networking: AnyNetworking<Data>

  // MARK: - Init
  init(networking: AnyNetworking<Data> = AnyNetworking(network: DataNetworking())) {
    self.networking = networking
  }

  // MARK: - Methods
  func requestEvents() -> AnyPublisher<[Event], NetworkError> {
    return networking.request(url: Api.eventsUrl)
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

//  static fileprivate func requestEvents() -> AnyPublisher<[Event], NetworkError> {
//    return Future<NetworkResponse<Data>, NetworkError> { promise in
//      AF.request(Api.eventsUrl).responseData { response in
//        // Método aqui
//      }
//    }
//    //método aqui
//    .eraseToAnyPublisher()
//  }
//
//  static fileprivate func request(from url: URL, method: HTTPMethod) -> AnyPublisher<NetworkResponse<Data>, NetworkError> {
//    return Future<NetworkResponse<Data>, NetworkError> { promise in
//      AF.request(url, method: method).responseData { response in
//        guard let statusCode = response.response?.status else {
//          promise(.failure(.withoutResponse))
//          return
//        }
//        if let data = response.data {
//          promise(.success(.nonEmpty(data, statusCode)))
//        } else {
//          promise(.success(.empty(statusCode)))
//        }
//      }
//    }
//    .eraseToAnyPublisher()
//  }
//
//  static func getEvents() -> AnyPublisher<[Event], NetworkError> {
//
//    return request(from: Api.eventsUrl, method: .get)
//      .tryMap { networkResponse -> [Event] in
//      switch networkResponse {
//      case let .nonEmpty(data, _):
//        do {
//          let decoded = try JSONDecoder().decode([Event].self, from: data)
//          return decoded
//        } catch {
//          throw NetworkError.decoding(error)
//        }
//      case .empty: throw NetworkError.emptyResponse
//      }
//    }
//    .mapError({ $0 as? NetworkError ?? .unknown($0) })
//    .eraseToAnyPublisher()
//  }

  static func requestImage(url: URL) -> AnyPublisher<Image, NetworkError> {
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

  static fileprivate let imageCache = AutoPurgingImageCache()
  static func getEventImage(url: URL) -> AnyPublisher<UIImage, NetworkError> {

    if let cachedImage = imageCache.image(withIdentifier: url.absoluteString) {
      return Result.Publisher(cachedImage).eraseToAnyPublisher()
    }

    return requestImage(url: url)
  }
}
