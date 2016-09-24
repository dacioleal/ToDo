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
    
}
