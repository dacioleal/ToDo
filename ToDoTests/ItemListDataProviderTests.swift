//
//  ItemListDataProviderTests.swift
//  ToDo
//
//  Created by Dacio Leal Rodriguez on 25/9/16.
//  Copyright © 2016 Dacio Leal Rodriguez. All rights reserved.
//

import XCTest
@testable import ToDo

class ItemListDataProviderTests: XCTestCase {
    
    var sut: ItemListDataProvider!
    var controller: ItemListViewController!
    var tableView: UITableView!
    
    override func setUp() {
        
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        sut = ItemListDataProvider()
        sut.itemManager = ItemManager()
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        controller = storyboard.instantiateViewController(withIdentifier: "ItemListViewController") as! ItemListViewController
        _ = controller.view
        tableView = controller.tableView
        tableView.dataSource = sut
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testNumberOfSectionsIsTwo() {
        
        let numberOfSections = tableView.numberOfSections
        XCTAssertEqual(numberOfSections, 2)
    }
    
    func testNumberOfRowsInFirstSection_IsToDoCount() {
        
        sut.itemManager!.addItem(ToDoItem(title: "First"))
        XCTAssertEqual(tableView.numberOfRows(inSection: 0), 1)
        
        sut.itemManager!.addItem(ToDoItem(title: "Second"))
        tableView.reloadData()
        XCTAssertEqual(tableView.numberOfRows(inSection: 0), 2)
    }
    
    func testNumberOfRowsInsecondSection_IsDoneCount() {
        
        sut.itemManager!.addItem(ToDoItem(title: "First"))
        sut.itemManager!.addItem(ToDoItem(title: "Second"))
        sut.itemManager!.checkItemAtIndex(0)
        XCTAssertEqual(tableView.numberOfRows(inSection: 1), 1)
        sut.itemManager!.checkItemAtIndex(0)
        tableView.reloadData()
        XCTAssertEqual(tableView.numberOfRows(inSection: 1), 2)
    }
    
    func testCellForRow_ReturnsItemCell() {
        
        sut.itemManager?.addItem(ToDoItem(title: "First"))
        tableView.reloadData()
        
        let cell = tableView.cellForRow(at: IndexPath(row: 0, section: 0))
        XCTAssertTrue(cell is ItemCell)
    }
    
    func testCellForRow_DequeuesCell() {
        
        let mockTableView = MockTableView.mockTableViewWithDataSource(sut)
        
        sut.itemManager?.addItem(ToDoItem(title: "First"))
        mockTableView.reloadData()
        _ = mockTableView.cellForRow(at: IndexPath(row: 0, section: 0))
        XCTAssertTrue(mockTableView.cellGotDequeued)
    }
    
    func testConfigCell_GetsCalledInCellForRow() {
        
        let mockTableView = MockTableView.mockTableViewWithDataSource(sut)
        
        let toDoItem = ToDoItem(title: "First")
        sut.itemManager?.addItem(toDoItem)
        mockTableView.reloadData()
        let cell = mockTableView.cellForRow(at: IndexPath(row: 0, section: 0)) as! MockItemCell
        XCTAssertEqual(cell.toDoItem, toDoItem)
        
    }
    
    func testCellsInSectionTwo_GetsConfiguredWithDoneItems() {
        
        let mockTableView = MockTableView.mockTableViewWithDataSource(sut)
        
        let firstItem = ToDoItem(title: "First")
        sut.itemManager?.addItem(firstItem)
        
        let secondItem = ToDoItem(title: "Second")
        sut.itemManager?.addItem(secondItem)
        
        sut.itemManager?.checkItemAtIndex(1)
        mockTableView.reloadData()
        
        let cell = mockTableView.cellForRow(at: IndexPath(row: 0, section: 1)) as! MockItemCell
        XCTAssertEqual(cell.toDoItem, secondItem)
    }
    
}

extension ItemListDataProviderTests {

    class MockTableView: UITableView {
        
        var cellGotDequeued = false
        
        override func dequeueReusableCell(withIdentifier identifier: String, for indexPath: IndexPath) -> UITableViewCell {
            cellGotDequeued = true
            return super.dequeueReusableCell(withIdentifier: identifier, for: indexPath)
        }
        
        class func mockTableViewWithDataSource(_ datasource: UITableViewDataSource) -> MockTableView {
            
            let rect = CGRect(x: 0, y: 0, width: 320, height: 480)
            let mockTableView = MockTableView(frame: rect, style: .plain)
            mockTableView.dataSource = datasource
            mockTableView.register(MockItemCell.classForKeyedArchiver(), forCellReuseIdentifier: "ItemCell")
            
            return mockTableView
        }
    }
    
    class MockItemCell: ItemCell {
        
        var toDoItem: ToDoItem?
        
        override func configCell(WithItem item: ToDoItem) {
            toDoItem = item
        }
    }
}





























