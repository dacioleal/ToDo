//
//  APIClient.swift
//  ToDo
//
//  Created by Dacio Leal Rodriguez on 22/10/16.
//  Copyright © 2016 Dacio Leal Rodriguez. All rights reserved.
//

import Foundation

class APIClient {
    
    lazy var session: ToDoURLSession = URLSession.shared as! ToDoURLSession
    
    func loginUser(name: String, password: String, completion: (Error?) -> Void) {
        
        let allowedCharacters = NSCharacterSet(charactersIn: "/%&=?$#+-~@<>|\\*,.()[]{}!").inverted
        guard let encodedUserName = name.addingPercentEncoding(withAllowedCharacters: allowedCharacters) else {
            fatalError()
        }
        
        guard let encodedPassword = password.addingPercentEncoding(withAllowedCharacters: allowedCharacters) else {
            fatalError()
        }

        
        guard let url = URL(string: "https://awesometodos.com/login?username=\(encodedUserName)&password=\(encodedPassword)") else {
            fatalError()
        }
        
        let task = session.dataTaskWithURL(url: url) { (data, response, error) in
            
        }
        task.resume()
        
    }
}

protocol ToDoURLSession {
    
    func dataTaskWithURL(url: URL, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask
}
