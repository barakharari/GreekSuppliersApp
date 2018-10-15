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
    @IBOutlet weak var continueButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        customizeNavBar()
        
        continueButton.layer.cornerRadius = 10
        timeInputField.keyboardType = .numberPad
        
        let tapScreen = UITapGestureRecognizer(target: self, action: #selector(doneTyping))
        view.addGestureRecognizer(tapScreen)
        
        let space = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let accessoryView = UIToolbar(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: 50))
        let doneButton = UIBarButtonItem(title: "Done", style: UIBarButtonItem.Style.done, target: self, action: #selector(doneTyping))
        accessoryView.items = [space, doneButton, space]
        timeInputField.inputAccessoryView = accessoryView
    }
    
    @objc func doneTyping(){
        view.endEditing(true)
    }
    
    func customizeNavBar(){
        navigationController?.navigationBar.tintColor = UIColor.white
        navigationController?.navigationBar.barTintColor = navBarColor
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white,NSAttributedString.Key.font: UIFont(name: "SourceSerifPro-Semibold", size: 19)!]
    }
}
