//
//  Event.swift
//  EventsApp
//
//  Created by Luis Gustavo Avelino de Lima Jacinto on 18/12/20.
//

import Foundation

struct Event: Codable, Hashable {
  let people: [String]
  let date: Date
  let description: String
  let image: String
  let longitude: Float
  let latitude: Float
  let price: Float
  let title: String
  let id: Int
}
