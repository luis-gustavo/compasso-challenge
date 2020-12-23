//
//  EventDetailsViewControllerScreenTests.swift
//  EventsAppTests
//
//  Created by Luis Gustavo Avelino de Lima Jacinto on 23/12/20.
//

import XCTest
import SnapshotTesting
@testable import EventsApp

class EventDetailsViewControllerScreenTests: XCTestCase {

  // MARK: - Properties

  // MARK: - Setup
  override func setUp() {
    super.setUp()
  }

  // MARK: - Tests
  func testScreenUI() {
    let screen = EventDetailViewControllerScreen(frame: .init(origin: .zero, size: CGSize(width: 500, height: 800)))
    screen.eventDate.text = "01/01/2020"
    screen.eventImage.image = UIImage(named: "errorImage")
    screen.eventPrice.text = "R$ 20,00"
    screen.eventDescription.text = "A nice description"

    assertSnapshot(matching: screen, as: .image)
  }

  // MARK: - TearDown
  override func tearDown() {
    super.tearDown()
  }

}
