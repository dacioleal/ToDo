//
//  APIClientTests.swift
//  ToDo
//
//  Created by Dacio Leal Rodriguez on 22/10/16.
//  Copyright © 2016 Dacio Leal Rodriguez. All rights reserved.
//

import XCTest
@testable import ToDo

class APIClientTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testLogin_MakeRequestWithUserNameAndPassword() {
        
        let sut = APIClient()
        let mockURLSession = MockURLSession()
        sut.session = mockURLSession
        
        let completion = { (error: Error?) in }
        sut.loginUser(name: "dasdöm", password: "%&34", completion: completion)
        XCTAssertNotNil(mockURLSession.completionHandler)
        
        guard let url = mockURLSession.url else {
            XCTFail()
            return
        }
        
        let urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: true)
        XCTAssertEqual(urlComponents?.host, "awesometodos.com")
        XCTAssertEqual(urlComponents?.path, "/login")
        
        
        let allowedCharacters = NSCharacterSet(charactersIn: "/%&=?$#+-~@<>|\\*,.()[]{}!").inverted
        guard let expectedUserName = "dasdöm".addingPercentEncoding(withAllowedCharacters: allowedCharacters) else {
            fatalError()
        }
        
        guard let expectedPassword = "%&34".addingPercentEncoding(withAllowedCharacters: allowedCharacters) else {
            fatalError()
        }
        
        XCTAssertEqual(urlComponents?.percentEncodedQuery, "username=\(expectedUserName)&password=\(expectedPassword)")
    }
    
}

extension APIClientTests {

    class MockURLSession: ToDoURLSession {
        
        typealias Handler = (Data, URLResponse, Error) -> Void
        
        var completionHandler: Handler?
        var url: URL?
        
        func dataTaskWithURL(url: URL, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
            
            self.url = url
            self.completionHandler = completionHandler
            return URLSession.shared.dataTask(with: url)
            
        }

    }
}
