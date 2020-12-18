//
//  NetworkError.swift
//  EventsApp
//
//  Created by Luis Gustavo Avelino de Lima Jacinto on 18/12/20.
//

import Foundation

public enum NetworkError: Error, Hashable, CustomStringConvertible {
  case withoutResponse
  case emptyResponse
  case dependency(Error)
  case decoding(Error)
  case unableToConvertToUIImage
  case unknown(Error)

  public var description: String {
    switch self {
    case .withoutResponse: return "Without response from the request."
    case .emptyResponse: return "The network response is empty."
    case .unableToConvertToUIImage: return "Unable to convert the response to an image."
    case .dependency(let error): return "Dependency: \(error.localizedDescription)"
    case .decoding(let error): return "Decoding: \(error.localizedDescription)"
    case .unknown(let error): return "Unknown: \(error.localizedDescription)"
    }
  }

  public var localizedDescription: String {
    return self.description
  }

  public static func == (lhs: NetworkError, rhs: NetworkError) -> Bool {
    return lhs.localizedDescription == rhs.localizedDescription
  }

  public func hash(into hasher: inout Hasher) {
    hasher.combine(self.localizedDescription)
  }
}
