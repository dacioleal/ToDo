//
//  ToDoItemTests.swift
//  ToDo
//
//  Created by Dacio Leal Rodriguez on 24/9/16.
//  Copyright © 2016 Dacio Leal Rodriguez. All rights reserved.
//

import XCTest
@testable import ToDo

class ToDoItemTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testInit_ShouldTakeTitle() {
        let item = ToDoItem(title: "Test title")
        XCTAssertNotNil(item, "item should not be nil")
    }
    
    
    func testInit_ShouldTakeTitleAndDescription() {
        let item = ToDoItem(title: "Test title", itemDescription: "Test description")
        XCTAssertNotNil(item, "item should not be nil")
    }
    
    func testInit_ShouldSetTitle() {
        let item = ToDoItem(title: "Test title")
        XCTAssertEqual(item.title, "Test title", "initializer should set the item title")
    }
    
    func testInit_ShouldSetTitleAndDescription() {
        let item = ToDoItem(title: "Test title", itemDescription: "Test description")
        XCTAssertEqual(item.title, "Test title", "initializer should set the item title")
        XCTAssertEqual(item.itemDescription, "Test description", "initializer should set the item description")
    }
    
    func testInit_ShouldSetTitleAndDescriptionAndTimestamp() {
        let item = ToDoItem(title: "Test title", itemDescription: "Test description", timestamp: 0.0)
        XCTAssertEqual(item.title, "Test title", "initializer should set the item title")
        XCTAssertEqual(item.itemDescription, "Test description", "initializer should set the item description")
        XCTAssertEqual(item.timestamp, 0.0, "initializer should set the item timestamp")
    }
    
    func testInit_ShouldSetTitleAndDescriptionAndTimestampAndLocation() {
        let location = Location(name: "Test name")
        let item = ToDoItem(title: "Test title", itemDescription: "Test description", timestamp: 0.0, location: location)
        XCTAssertEqual(item.location?.name, location.name, "Initializer should set the location")
    }
}
