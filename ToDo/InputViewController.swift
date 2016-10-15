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
    
    lazy var geocoder = CLGeocoder()
    var itemManager: ItemManager?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func save() {
        
    }
    

}
