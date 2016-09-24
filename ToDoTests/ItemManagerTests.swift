//
//  ItemManagerTests.swift
//  ToDo
//
//  Created by Dacio Leal Rodriguez on 24/9/16.
//  Copyright © 2016 Dacio Leal Rodriguez. All rights reserved.
//

import XCTest
@testable import ToDo

class ItemManagerTests: XCTestCase {
    
    var sut: ItemManager!
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        sut = ItemManager()
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testToDoCount_Initially_ShouldBeZero() {
        
        XCTAssertEqual(sut.toDoCount, 0, "Initially toDoCount should be zero")
    }
    
    func testDoneCount_Initially_ShouldBeZero() {
        
        XCTAssertEqual(sut.doneCount, 0, "Initially doneCount should be zero")
    }
    
    func testToDoCount_AfterAddingOneItem_IsOne() {
        
        sut.addItem(ToDoItem(title: "Test title"))
        XCTAssertEqual(sut.toDoCount, 1, "toDoCount should be 1 ")
        
    }
    
    func testItemAtIndex_ShouldReturnPreviouslyAddedItem() {
        
        let item = ToDoItem(title: "Test title")
        sut.addItem(item)
        let returnedItem = sut.itemAtIndex(0)
        XCTAssertEqual(returnedItem.title, item.title, "should be the same item")
    }
    
    func testCheckingItem_ChangesCountOfToDoAndDoneItems() {
        sut.addItem(ToDoItem(title: "First item"))
        sut.checkItemAtIndex(0)
        XCTAssertEqual(sut.toDoCount, 0, "toDoCount should be zero")
        XCTAssertEqual(sut.doneCount, 1, "doneCount should be 1")
    }
    
}
