//
//  ProductCell.swift
//  GreekSuppliers
//
//  Created by Barak on 10/13/18.
//  Copyright © 2018 Harariapps. All rights reserved.
//

import UIKit
import Firebase

class ProductCell: UICollectionViewCell {
    
    @IBOutlet weak var productImageView: UIImageView!
    @IBOutlet weak var productName: UILabel!
    @IBOutlet weak var clearButton: UIButton!
    @IBOutlet weak var productAmount: UILabel!
    
    @IBAction func clearButtonPressed(_ sender: UIButton) {
        if let user = Auth.auth().currentUser{
            let ref = Database.database().reference().child("users").child(user.uid).child("ProductInfo").child(productName.text!)
            ref.removeValue()
        }
    }
    
    override func layoutSubviews() {
        //Styling
        productImageView.layer.cornerRadius = 8
        productImageView.layer.borderColor = UIColor.lightGray.cgColor
        productImageView.layer.borderWidth = 0.5
        productImageView.clipsToBounds = true
        
        productName.layer.borderColor = UIColor.lightGray.cgColor
        clearButton.layer.cornerRadius = clearButton.frame.width / 2
        clearButton.layer.borderWidth = 1.0
        productAmount.backgroundColor = UIColor(red: 210/255, green: 31/255, blue: 60/255, alpha: 1.0)
        productAmount.textColor = UIColor.white
        productAmount.layer.borderWidth = 0.5
        productAmount.layer.borderColor = UIColor.lightGray.cgColor
        
        let rectShape = CAShapeLayer()
        rectShape.bounds = productAmount.frame
        rectShape.position = productAmount.center
        rectShape.path = UIBezierPath(roundedRect: productAmount.bounds, byRoundingCorners: [.bottomRight , .topLeft], cornerRadii: CGSize(width: 8, height: 8)).cgPath
        productAmount.layer.mask = rectShape
    }
}
