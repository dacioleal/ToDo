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
    
    var sut: APIClient!
    var mockURLSession: MockURLSession!
    
    override func setUp() {
        super.setUp()
        sut = APIClient()
        mockURLSession = MockURLSession()
        sut.session = mockURLSession
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testLogin_MakeRequestWithUserNameAndPassword() {
        
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
    
    
    func testLogin_CallsResumeOnDataTask() {
        
        let completion = { (error: Error?) in }
        sut.loginUser(name: "dasdom", password: "1234", completion: completion)
        XCTAssertTrue(mockURLSession.dataTask.resumeGotCalled)
    }
    
    
    func testLogin_SetsToken() {
        
        let mockKeyChainManager = MockKeyChainManager()
        sut.keyChainManager = mockKeyChainManager
        
        let completion = { (error: Error?) in }
        sut.loginUser(name: "dasdom", password: "1234", completion: completion)
        
        let responseDict = ["token" : "1234567890"]
        do {
            let responseData = try JSONSerialization.data(withJSONObject: responseDict, options: .prettyPrinted)
            mockURLSession.completionHandler?(responseData, nil, nil)
            let token = mockKeyChainManager.passwordForAccount(account: "token")
            XCTAssertEqual(token, responseDict["token"])
        } catch {
            print(error.localizedDescription)
        }
    }
}



extension APIClientTests {

    class MockURLSession: ToDoURLSession {
        
        typealias Handler = (Data?, URLResponse?, Error?) -> Void
        var completionHandler: Handler?
        var url: URL?
        var dataTask = MockURLSessionDataTask()
        
        func dataTaskWithURL(url: URL, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
            self.url = url
            self.completionHandler = completionHandler
            return dataTask
        }
    }
    
    class MockURLSessionDataTask: URLSessionDataTask {
        
        var resumeGotCalled = false
        
        override func resume() {
            resumeGotCalled = true
        }
    }

    class MockKeyChainManager: KeyChainAccesible {
        
        var passwordDict = [String : String]()
        
        func setPassword(password: String, account: String) {
            passwordDict[account] = password
        }
        
        func deletePasswordForAccount(account: String) {
            passwordDict.removeValue(forKey: account)
        }
        
        func passwordForAccount(account: String) -> String? {
            return passwordDict[account]
        }

    }
}














