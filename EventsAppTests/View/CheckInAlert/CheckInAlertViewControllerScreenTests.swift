//
//  CheckInAlertViewControllerScreenTests.swift
//  EventsAppTests
//
//  Created by Luis Gustavo Avelino de Lima Jacinto on 23/12/20.
//

import XCTest
import SnapshotTesting
@testable import EventsApp

class CheckInAlertViewControllerScreenTests: XCTestCase {

  // MARK: - Properties

  // MARK: - Setup
  override func setUp() {
    super.setUp()
  }

  // MARK: - Tests
  func testScreenUI() {
    let screen = CheckInAlertViewControllerScreen(frame: .init(origin: .zero, size: CGSize(width: 500, height: 800)))

    assertSnapshot(matching: screen, as: .image)
  }

  // MARK: - TearDown
  override func tearDown() {
    super.tearDown()
  }

}
