//
//  DealCell.swift
//  GreekSuppliers
//
//  Created by Barak on 10/12/18.
//  Copyright © 2018 Harariapps. All rights reserved.
//

import UIKit

class DealCell: UICollectionViewCell {
    
    @IBOutlet weak var dealLabel: UILabel!
    @IBOutlet weak var dealConfirmButton: UIButton!
    
    var buttonSelected = false
    
    @IBAction func dealButtonPressed(_ sender: UIButton) {
        
        if !buttonSelected{
            dealConfirmButton.setTitle("Got it", for: .normal)
            dealConfirmButton.layer.backgroundColor = UIColor.green.cgColor
            buttonSelected = true
        } else{
            dealConfirmButton.setTitle("Sure!", for: .normal)
            dealConfirmButton.layer.backgroundColor = UIColor.lightGray.cgColor
            buttonSelected = false
        }
        
    }
}
