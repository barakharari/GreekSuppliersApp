//
//  ExistingOrderCell.swift
//  GreekSuppliers
//
//  Created by Barak on 10/31/18.
//  Copyright © 2018 Harariapps. All rights reserved.
//

import UIKit

class ExistingOrderCell: UICollectionViewCell, UICollectionViewDataSource, UICollectionViewDelegate {
    
    @IBOutlet weak var existingOrderCollectionView: UICollectionView!
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ExistingOrderItemCell", for: indexPath) as! ExistingOrderItemCell
        return cell
    }
}
