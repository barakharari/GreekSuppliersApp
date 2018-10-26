//
//  TierCell.swift
//  GreekSuppliers
//
//  Created by Barak on 10/14/18.
//  Copyright © 2018 Harariapps. All rights reserved.
//

import UIKit

class TierCell: UICollectionViewCell{
    
    @IBOutlet weak var tierAmount: UILabel!
    @IBOutlet weak var tierPrice: UILabel!
    @IBOutlet weak var acceptButton: UIButton!
    
    var buttonSelected: Bool = false
    
    weak var delegate: CellClickedDelegate!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    @IBAction func pressAcceptButton(_ sender: UIButton) {
        delegate.clickedCell()
        if !buttonSelected{
            acceptButton.setTitle("✓", for: .normal)
            acceptButton.layer.backgroundColor = UIColor.green.cgColor
            buttonSelected = true
        } else{
            // make it a checkmark
            acceptButton.setTitle("+", for: .normal)
            acceptButton.layer.backgroundColor = UIColor.lightGray.cgColor
            buttonSelected = false
        }
    }
    
    override func layoutSubviews() {
        // Styling
        layer.borderWidth = 1.5
        layer.borderColor = navBarColor.cgColor
        layer.cornerRadius = 10
        acceptButton.layer.cornerRadius = 10
    }
}
