//
//  OrderSummaryVC.swift
//  GreekSuppliers
//
//  Created by Barak on 10/12/18.
//  Copyright © 2018 Harariapps. All rights reserved.
//

import UIKit

class OrderSummaryVC: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        customizeNavBar()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "OrderCell", for: indexPath)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let footer = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: "PriceFooter", for: indexPath) as! PriceFooter
        return footer
    }
    func customizeNavBar(){
        navigationController?.navigationBar.tintColor = UIColor.white
        navigationController?.navigationBar.barTintColor = navBarColor
        
        
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
    }

}
