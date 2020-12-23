//
//  EventImageTests.swift
//  EventsAppTests
//
//  Created by Luis Gustavo Avelino de Lima Jacinto on 23/12/20.
//

import XCTest
import SnapshotTesting
@testable import EventsApp

class EventImageTests: XCTestCase {

  // MARK: - Properties

  // MARK: - Setup
  override func setUp() {
    super.setUp()
  }

  // MARK: - Tests
  func testEventImageUI() {
    let eventImage = EventImage(frame: CGRect(origin: .zero, size: CGSize(width: 200, height: 200)))
    eventImage.image = UIImage(named: "errorImage")

    assertSnapshot(matching: eventImage, as: .image)
  }

  // MARK: - TearDown
  override func tearDown() {
    super.tearDown()
  }

}
