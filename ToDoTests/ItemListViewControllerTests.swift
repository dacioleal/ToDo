//
//  ItemListViewControllerTests.swift
//  ToDo
//
//  Created by Dacio Leal Rodriguez on 25/9/16.
//  Copyright © 2016 Dacio Leal Rodriguez. All rights reserved.
//

import XCTest
@testable import ToDo

class ItemListViewControllerTests: XCTestCase {
    
    var sut: ItemListViewController!
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        sut = storyBoard.instantiateViewController(withIdentifier: "ItemListViewController") as! ItemListViewController
        _ = sut.view
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func test_TableViewIsNotNilAfterViewDidLoad() {
        XCTAssertNotNil(sut.tableView, "tableview should not be nil")
    }
    
    func testViewDidLoad_ShouldSetTableViewDataSource() {
        XCTAssertNotNil(sut.tableView.dataSource)
        XCTAssertTrue(sut.tableView.dataSource is ToDo.ItemListDataProvider)
    }
}
