//
//  ViewController.swift
//  EventsApp
//
//  Created by Luis Gustavo Avelino de Lima Jacinto on 18/12/20.
//

import UIKit
import Combine

final class ViewController: UIViewController {

  var cancellable = [AnyCancellable]()

  override func viewDidLoad() {
    super.viewDidLoad()

    EventNetworking
      .getEvents()
      .sink { completion in
        print(completion)
      } receiveValue: { events in
        events.forEach({ print($0) })
      }.store(in: &cancellable)

  }
}
