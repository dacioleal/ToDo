//
//  ToDoItem.swift
//  ToDo
//
//  Created by Dacio Leal Rodriguez on 24/9/16.
//  Copyright © 2016 Dacio Leal Rodriguez. All rights reserved.
//

import Foundation


struct ToDoItem {
    
    let title: String
    let itemDescription: String?
    let timestamp: Double?
    let location: Location?
    
    init(title: String, itemDescription: String? = nil, timestamp: Double? = nil, location: Location? = nil) {
        self.title = title
        self.itemDescription = itemDescription
        self.timestamp = timestamp
        self.location = location
    }

}
