//
//  TierCell.swift
//  GreekSuppliers
//
//  Created by Barak on 10/14/18.
//  Copyright © 2018 Harariapps. All rights reserved.
//

import UIKit

class TierCell: UICollectionViewCell {
    @IBOutlet weak var tierName: UILabel!
    @IBOutlet weak var tierAmount: UILabel!
    @IBOutlet weak var tierPrice: UILabel!
    @IBOutlet weak var acceptButton: UIButton!
    
    var buttonSelected = false
    
    @IBAction func pressAcceptButton(_ sender: UIButton) {
        if !buttonSelected{
            acceptButton.setTitle(":)", for: .normal)
            acceptButton.layer.backgroundColor = UIColor.green.cgColor
            buttonSelected = true
        } else{
            // make it a checkmark
            acceptButton.setTitle("+", for: .normal)
            acceptButton.layer.backgroundColor = UIColor.lightGray.cgColor
            buttonSelected = false
        }
    }
}
