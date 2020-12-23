//
//  CheckInResultAlertViewControllerScreenTests.swift
//  EventsAppTests
//
//  Created by Luis Gustavo Avelino de Lima Jacinto on 23/12/20.
//

import XCTest
import SnapshotTesting
@testable import EventsApp

class CheckInResultAlertViewControllerScreenTests: XCTestCase {

  // MARK: - Properties

  // MARK: - Setup
  override func setUp() {
    super.setUp()
  }

  // MARK: - Tests
  func testScreenUI() {
    let screen = CheckInResultAlertViewControllerScreen(frame: .init(origin: .zero, size: CGSize(width: 500, height: 800)))
    screen.titleLabel.text = "Title"
    screen.descriptionLabel.text = "Descriptino"

    assertSnapshot(matching: screen, as: .image)
  }

  // MARK: - TearDown
  override func tearDown() {
    super.tearDown()
  }

}
