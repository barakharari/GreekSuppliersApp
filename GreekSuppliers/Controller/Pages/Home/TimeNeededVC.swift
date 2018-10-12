//
//  TimeNeededVC.swift
//  GreekSuppliers
//
//  Created by Barak on 10/12/18.
//  Copyright © 2018 Harariapps. All rights reserved.
//

import UIKit

class TimeNeededVC: UIViewController {
    
    @IBOutlet weak var timeInputField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        customizeNavBar()
    }

    func customizeNavBar(){
        navigationController?.navigationBar.tintColor = UIColor.white
        navigationController?.navigationBar.barTintColor = navBarColor
        
        
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
    }
}
