//
//  InputViewControllerTests.swift
//  ToDo
//
//  Created by Dacio Leal Rodriguez on 9/10/16.
//  Copyright © 2016 Dacio Leal Rodriguez. All rights reserved.
//

import XCTest
import CoreLocation
@testable import ToDo

class InputViewControllerTests: XCTestCase {
    
    var sut: InputViewController!
    var placeMark: MockPlaceMark!
    
    
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
    
    func test_HasDateTextField() {
        
        XCTAssertNotNil(sut.dateTextField)
    }
    
    func test_HasLocationTextField() {
        
        XCTAssertNotNil(sut.locationTextField)
    }
    
    func test_HasAddressTextField() {
        
        XCTAssertNotNil(sut.addressTextField)
    }
    
    func test_HasDescriptionTextField() {
        
        XCTAssertNotNil(sut.descriptionTextField)
    }
    
    func testSave_UsesGeocoderToGetCoordinateFromAddress() {
        
        sut.titleTextField.text = "Test Title"
        sut.dateTextField.text = "02/22/2016"
        sut.locationTextField.text = "Office"
        sut.addressTextField.text = "Infinite Loop 1, Cupertino"
        sut.descriptionTextField.text = "Test Description"
        
        let mockGeocoder = MockGeoCoder()
        sut.geocoder = mockGeocoder
        
        sut.itemManager = ItemManager()
        
        sut.save()
        
        placeMark = MockPlaceMark()
        let coordinate = CLLocationCoordinate2D(latitude: 37.3316851, longitude: -122.0300674)
        placeMark.mockCoordinate = coordinate
        mockGeocoder.completionHandler?([placeMark], nil)
        
        let item = sut.itemManager?.itemAtIndex(0)
        
        let testItem = ToDoItem(title: "Test Title", itemDescription: "Test Description", timestamp: 1456095600, location: Location(name: "Office", coordinate: coordinate))
        
        XCTAssertEqual(item, testItem)
    }
    
    
}

extension InputViewControllerTests {
    
    class MockGeoCoder: CLGeocoder {
        
        var completionHandler: CLGeocodeCompletionHandler?
        
        override func geocodeAddressString(_ addressString: String, completionHandler: @escaping CLGeocodeCompletionHandler) {
            
            self.completionHandler = completionHandler
        }
    }
    
    class MockPlaceMark: CLPlacemark {
        
        var mockCoordinate: CLLocationCoordinate2D?
        
        override var location: CLLocation? {
            
            guard let coordinate = mockCoordinate else {
                return CLLocation()
            }
            
            return CLLocation(latitude: coordinate.latitude, longitude: coordinate.longitude)
        }
    }
    
}






































