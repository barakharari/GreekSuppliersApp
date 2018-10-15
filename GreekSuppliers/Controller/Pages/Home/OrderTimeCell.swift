//
//  OrderTimeCell.swift
//  GreekSuppliers
//
//  Created by Barak on 10/12/18.
//  Copyright © 2018 Harariapps. All rights reserved.
//

import UIKit

class OrderTimeCell: UICollectionViewCell {
    
    @IBOutlet weak var orderNumberLabel: UILabel!
    @IBOutlet weak var timeTextField: UITextField!
    @IBOutlet weak var dayTextField: UITextField!
    
    var datePicker: UIDatePicker!
    
    @objc func updateTextField(){
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd/yyyy"
        dayTextField.text = dateFormatter.string(from: datePicker.date)
        dateFormatter.dateFormat = "hh:mm a"
        dayTextField.text = dayTextField.text! + " at " + dateFormatter.string(from: datePicker.date)
        super.endEditing(true)
    }
}
