//
//  InputViewControllerTests.swift
//  ToDo
//
//  Created by Dacio Leal Rodriguez on 9/10/16.
//  Copyright © 2016 Dacio Leal Rodriguez. All rights reserved.
//

import XCTest
@testable import ToDo

class InputViewControllerTests: XCTestCase {
    
    var sut: InputViewController!
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        sut = storyboard.instantiateViewController(withIdentifier: "InputViewController") as! InputViewController
        _ = sut.view
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func test_HasTitleTextField() {
        
        XCTAssertNotNil(sut.titleTextField)
    }
    
    
}
