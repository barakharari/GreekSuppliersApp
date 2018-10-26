//
//  MenuHeader.swift
//  GreekSuppliers
//
//  Created by Barak on 10/11/18.
//  Copyright © 2018 Harariapps. All rights reserved.
//

import UIKit
import Firebase

class MenuHeader: UICollectionReusableView {
    
    @IBOutlet weak var menuHeaderLabel: UILabel!
    @IBOutlet weak var menuHeaderImage: UIImageView!
    
    override func layoutSubviews() {
        if let user = Auth.auth().currentUser{
            let ref = Database.database().reference().child("users").child(user.uid)
            ref.observeSingleEvent(of: .value) { (snapshot) in
                if let name = snapshot.value as? [String: AnyObject]{
                    self.menuHeaderLabel.text = name["name"] as? String
                }
            }
        }
        menuHeaderImage.layer.cornerRadius = menuHeaderImage.frame.size.width / 2
    }
}
