//
//  EventsTableViewCellTests.swift
//  EventsAppTests
//
//  Created by Luis Gustavo Avelino de Lima Jacinto on 23/12/20.
//

import XCTest
import SnapshotTesting
@testable import EventsApp

class EventsTableViewCellTests: XCTestCase {

  // MARK: - Properties

  // MARK: - Setup
  override func setUp() {
    super.setUp()
  }

  // MARK: - Tests
  func testEventsCellUI() {
    let eventsCell = EventsTableViewCell(frame: CGRect(origin: .zero, size: CGSize(width: 200, height: 200)))
    eventsCell.imageView?.image = UIImage(named: "errorImage")
    eventsCell.eventTitle.text = "Event Title"

    assertSnapshot(matching: eventsCell, as: .image)
  }

  // MARK: - TearDown
  override func tearDown() {
    super.tearDown()
  }

}
