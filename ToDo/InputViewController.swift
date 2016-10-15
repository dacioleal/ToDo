//
//  InputViewController.swift
//  ToDo
//
//  Created by Dacio Leal Rodriguez on 9/10/16.
//  Copyright © 2016 Dacio Leal Rodriguez. All rights reserved.
//

import UIKit
import CoreLocation

class InputViewController: UIViewController {

    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var dateTextField: UITextField!
    @IBOutlet weak var locationTextField: UITextField!
    @IBOutlet weak var addressTextField: UITextField!
    @IBOutlet weak var descriptionTextField: UITextField!
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var cancelButton: UIButton!
    
    lazy var geocoder = CLGeocoder()
    var itemManager: ItemManager?
    
    let dateFormatter: DateFormatter = {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd/yyyy"
        return dateFormatter
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func save() {
        
        guard let titleString = titleTextField.text else {
            return
        }
        
        if titleString.characters.count > 0 {
            
            let date: Date?
            
            if (dateTextField.text?.characters.count)! > 0 {
                
                let dateText = dateTextField.text
                date = dateFormatter.date(from: dateText!)
                
            } else {
                date = nil
            }
            
            let descriptionString: String?
            
            if (descriptionTextField.text?.characters.count)! > 0 {
                
                descriptionString = descriptionTextField.text
                
            } else {
                
                descriptionString = nil
            }
            
            if (locationTextField.text?.characters.count)! > 0 {
                
                if  let locationName = locationTextField.text {
                    
                    if (addressTextField.text?.characters.count)! > 0 {
                        
                        let addressString = addressTextField.text
                        
                        if let address = addressString {
                            
                            geocoder.geocodeAddressString(address, completionHandler: { [unowned self] (placeMarks, error) in
                                
                                let placeMark = placeMarks?.first
                                let item = ToDoItem(title: titleString, itemDescription: descriptionString, timestamp: date?.timeIntervalSince1970, location: Location(name: locationName, coordinate: placeMark?.location?.coordinate))
                                self.itemManager?.addItem(item)
                                
                            })
                        }
                    }
                }
            }
            
        } else {
            return
        }
    }
    

}
