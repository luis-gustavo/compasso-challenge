//
//  NetworkResponse.swift
//  EventsApp
//
//  Created by Luis Gustavo Avelino de Lima Jacinto on 18/12/20.
//

import Foundation

public enum NetworkResponse<Body>: Hashable where Body: Hashable {
  case empty(HTTPStatusCode)
  case nonEmpty(Body, HTTPStatusCode)

  var status: HTTPStatusCode {
    switch self {
    case .empty(let status): return status
    case .nonEmpty(_, let status): return status
    }
  }
}
