//
//  DealsPageVC.swift
//  GreekSuppliers
//
//  Created by Barak on 10/12/18.
//  Copyright © 2018 Harariapps. All rights reserved.
//

import UIKit

class DealsPageVC: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        customizeNavBar()
    }
    func customizeNavBar(){
        navigationController?.navigationBar.tintColor = UIColor.white
        navigationController?.navigationBar.barTintColor = navBarColor
        
        
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DealCell", for: indexPath)
        return cell
    }
    
}
