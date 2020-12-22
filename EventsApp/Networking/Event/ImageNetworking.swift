//
//  ImageNetworking.swift
//  EventsApp
//
//  Created by Luis Gustavo Avelino de Lima Jacinto on 22/12/20.
//

import UIKit
import Combine
import Alamofire
import AlamofireImage

final class ImageNetworking: Networking {
  fileprivate let imageCache = AutoPurgingImageCache()

  func request(url: URL, method: HTTPMethod, parameters: AnyEncodable?, encoder: ParameterEncoder?) -> AnyPublisher<NetworkResponse<UIImage>, NetworkError> {
    if let cachedImage = imageCache.image(withIdentifier: url.absoluteString) {
      return Result.Publisher(.success(.nonEmpty(cachedImage, .ok))).eraseToAnyPublisher()
    }

    return Future { promise in
      AF.request(url).responseImage { response in
        switch response.result {
        case .success(let image):
          self.imageCache.add(image, withIdentifier: url.absoluteString)
          promise(.success(.nonEmpty(image, .ok)))
        case .failure(let error):
          promise(.failure(.dependency(error)))
        }
      }
    }
    .eraseToAnyPublisher()
  }
}
