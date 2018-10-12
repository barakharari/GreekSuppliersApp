//
//  AvailabilityPageVC.swift
//  GreekSuppliers
//
//  Created by Barak on 10/12/18.
//  Copyright © 2018 Harariapps. All rights reserved.
//

import UIKit

class AvailabilityPageVC: UIViewController {

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
