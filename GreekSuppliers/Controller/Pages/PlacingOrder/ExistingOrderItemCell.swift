//
//  ExistingOrderItemCell.swift
//  GreekSuppliers
//
//  Created by Barak on 10/31/18.
//  Copyright © 2018 Harariapps. All rights reserved.
//

import UIKit

class ExistingOrderItemCell: UICollectionViewCell {
    
    @IBOutlet weak var itemImage: UIImageView!
    @IBOutlet weak var amountLabel: UILabel!
    
    override func layoutSubviews() {
        itemImage.layer.cornerRadius = 10
        itemImage.layer.borderWidth = 0.5
        itemImage.layer.borderColor = UIColor.lightGray.cgColor
    }
}
