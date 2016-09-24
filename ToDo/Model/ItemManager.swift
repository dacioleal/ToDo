//
//  ItemManager.swift
//  ToDo
//
//  Created by Dacio Leal Rodriguez on 24/9/16.
//  Copyright © 2016 Dacio Leal Rodriguez. All rights reserved.
//

import Foundation

class ItemManager {
    
    var toDoCount = 0
    var doneCount = 0
    
    private var toDoItems = [ToDoItem]()
    
    func addItem(_ item: ToDoItem) {
        
        toDoCount += 1
        toDoItems.append(item)
    }
    
    func itemAtIndex(_ index: Int) -> ToDoItem {
        
        return toDoItems[index]
    }
    
    func checkItemAtIndex(_ index: Int) {
        
        toDoCount += -1
        doneCount += 1
    }
    
}
