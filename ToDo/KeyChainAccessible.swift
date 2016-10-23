//
//  KeyChainAccessible.swift
//  ToDo
//
//  Created by Dacio Leal Rodriguez on 23/10/16.
//  Copyright © 2016 Dacio Leal Rodriguez. All rights reserved.
//

import Foundation


protocol KeyChainAccesible {
    
    func setPassword(password: String, account: String)
    
    func deletePasswordForAccount(account: String)
    
    func passwordForAccount(account: String) -> String?
}
