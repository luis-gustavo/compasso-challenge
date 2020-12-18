//
//  AppDelegate.swift
//  EventsApp
//
//  Created by Luis Gustavo Avelino de Lima Jacinto on 18/12/20.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

  var window: UIWindow?

  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
    // Override point for customization after application launch.

    // Setup Coordinator
    let mainCoordinator = MainCoordinator()
    mainCoordinator.start()

    // Setup window
    self.window = UIWindow(frame: UIScreen.main.bounds)
    self.window?.makeKeyAndVisible()
    self.window?.rootViewController = mainCoordinator.navigationController

    return true
  }
}

