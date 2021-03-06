//
//  Api.swift
//  EventsApp
//
//  Created by Luis Gustavo Avelino de Lima Jacinto on 18/12/20.
//

import Foundation

struct Api {

  static fileprivate let path = "http://5f5a8f24d44d640016169133.mockapi.io/api"

  static fileprivate var hostUrl: URL {
    guard let hostUrl = URL(string: path) else {
      preconditionFailure("The url from path must exist")
    }

    return hostUrl
  }

  static var eventsUrl: URL {
    return hostUrl
      .appendingPathComponent("events")
  }

  static var checkinUrl: URL {
    return hostUrl
      .appendingPathComponent("checkin")
  }
}
