//
//  ItemListDataProvider.swift
//  ToDo
//
//  Created by Dacio Leal Rodriguez on 25/9/16.
//  Copyright © 2016 Dacio Leal Rodriguez. All rights reserved.
//

import UIKit

class ItemListDataProvider: NSObject, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }

}
